import json
from shlex import split
from subprocess import check_output
import sys


IMG = 'makukha/multipython:unsafe'
BAKE = 'tests/docker-bake.hcl'
TAG_REMOVE = 'py20'
POS = '✅'
NEG = '🚫'

# ruff: noqa: S603 = check_output()


def print_table(venv_spec: str) -> None:
    # get source data
    tags = check_output(
        split(f'docker run --rm {IMG} py ls --tag'),
        text=True,
    ).splitlines()
    bake = json.loads(check_output(split(f'docker buildx bake -f {BAKE} --print')))

    # make table
    def table_row(row: dict) -> dict:
        marks = [
            *((t, True) for t in row['TAGS_PASSING'].split()),
            *((t, False) for t in set(row['TAGS_NOTFOUND'].split()) - {TAG_REMOVE}),
        ]
        marks.sort(key=lambda tm: tags.index(tm[0]))
        return dict(tag=row['TOX_TAG'], marks=marks)

    table = [
        table_row(t['args'])
        for t in bake['target'].values()
        if t['args']['VIRTUALENV_PIN'] == venv_spec
    ]
    table.sort(key=lambda row: tags.index(row['tag']))

    # print html
    for row in table:
        vals = ''.join(f'<td>{POS if tm[1] else NEG}</td>' for tm in row['marks'])
        print(f'<tr><th><code>{row['tag']}</code></th>{vals}</tr>')


if __name__ == '__main__':
    print_table(venv_spec=sys.argv[1])
