from __future__ import print_function
import logging
import os
import re
from subprocess import check_output
import sys

try:
    from typing import TYPE_CHECKING, Union
except ImportError:
    TYPE_CHECKING = False

# ruff: noqa: F401
if TYPE_CHECKING:
    import argparse  # type: ignore[unused-ignore]

from virtualenv.discovery.builtin import Builtin  # type: ignore
from virtualenv.discovery.discover import Discover  # type: ignore
from virtualenv.discovery.py_info import PythonInfo  # type: ignore

# debug logging

DEBUG = bool(os.environ.get('MULTIPYTHON_DEBUG', False))
if DEBUG:
    try:
        from loguru import logger
    except ImportError:
        logging.basicConfig(level=logging.DEBUG)
        logger = logging  # type: ignore

    debug = logger.debug
    exception = logger.exception


RX = (
    re.compile(r'^(?P<impl>py)(?P<maj>[23])(?P<min>[0-9][0-9]?)$'),
    re.compile(r'^(?P<impl>py)(?P<maj>3)(?P<min>[0-9][0-9])(?P<suffix>t)$'),
)


class MultiPython(Discover):  # type: ignore[misc]
    def __init__(self, options):  # type: (argparse.Namespace) -> None
        if DEBUG:
            debug('Creating MultiPython with options: {}'.format(options.__dict__))
        super(MultiPython, self).__init__(options)
        self.requests = options.try_first_with + options.python
        if not len(self.requests):
            if sys.executable:
                self.requests.append(sys.executable)
                if DEBUG:
                    debug('No versions requested, added sys.executable')
            else:
                if DEBUG:
                    debug('No versions requested, and unable to get sys.executable')

    @classmethod
    def add_parser_arguments(cls, parser):  # type: (argparse.ArgumentParser) -> None
        Builtin.add_parser_arguments(parser)

    def run(self):  # type: () -> Union[PythonInfo, None]
        ret = None
        for python in self.requests:
            if os.path.isabs(python) and os.path.exists(python):
                if DEBUG:
                    debug('Candidate path: {}'.format(python))
                ret = self.get_path_info(python)
            else:
                for rx in RX:
                    if rx.match(python):
                        if DEBUG:
                            debug('Candidate tag: {}'.format(python))
                        ret = self.get_tag_info(python)
            if ret:
                break

        if DEBUG:
            debug('Returning result: {}'.format(ret))
        return ret

    def get_path_info(self, path):  # type: (str) -> Union[PythonInfo, None]
        info = None
        if path:
            try:
                info = PythonInfo.from_exe(path, resolve_to_host=False)
                if info and not info.system_executable:
                    info.system_executable = sys.executable
                    if DEBUG:
                        debug('Pinned system_executable: {}'.format(sys.executable))
            except Exception:
                if DEBUG:
                    exception('Failed to get PythonInfo for path "{}"'.format(path))
        return info

    def get_tag_info(self, tag):  # type: (str) -> Union[PythonInfo, None]
        try:
            # ruff: noqa: S603 = allow check_output with arbitrary cmdline
            # ruff: noqa: S607 = py is on path, specific location is not guaranteed
            out = check_output(['py', 'bin', '--path', tag])
            enc = sys.getfilesystemencoding()
            path = (out.decode() if enc is None else out.decode(enc)).strip()
            return self.get_path_info(path)
        except Exception:
            if DEBUG:
                exception('Failed to call "py bin --path {}"'.format(tag))
        return None
