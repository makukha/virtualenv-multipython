# virtualenv-multipython
> virtualenv discovery plugin for [tox](https://tox.wiki) 4 and [multipython](https://github.com/makukha/multipython)

[![license](https://img.shields.io/github/license/makukha/virtualenv-multipython.svg)](https://github.com/makukha/virtualenv-multipython/blob/main/LICENSE)
[![versions](https://img.shields.io/pypi/pyversions/virtualenv-multipython.svg)](https://pypi.org/project/virtualenv-multipython)
[![pypi](https://img.shields.io/pypi/v/virtualenv-multipython.svg#v0.2.1)](https://pypi.python.org/pypi/virtualenv-multipython)
[![tested with multipython](https://img.shields.io/badge/tested_with-multipython-x)](https://github.com/makukha/multipython)

> [!NOTE]
> [virtualenv-multipython]() has twin plugin [tox-multipython](https://github.com/makukha/tox-multipython) that serves the same purpose for [tox](https://tox.wiki) 3

This [virtualenv](https://virtualenv.pypa.io) plugin comes pre-installed in [multipython](https://hub.docker.com/r/makukha/multipython) Docker image and is responsible for resolving tox environment name to Python executable. Most probably, you don't need to install it yourself.

Environment names supported are all multipython tags, including free threading Python builds `py313t` and `py314t`. More names may be added in the future.

> [!IMPORTANT]
> This plugin does not fall back to tox python: interpreter discovery errors are explicit.

# Testing, tox 4

When `virtualenv-multipython` is installed inside *Host tag* environment, it allows to use selected ✅ *Target tag* inside `env_list` in `tox.ini` and automatically discovers corresponding [multipython](https://hub.docker.com/r/makukha/multipython) executable. For failing ⚠️ *Target tag*, python executable is not discoverable.

*Host tag* and *Target tags* are valid [multipython](https://hub.docker.com/r/makukha/multipython) tags.

For Python below 3.7, tox 4 is not available.

## For `virtualenv>=20`

<table>
<thead>
<tr>
    <th rowspan="2">Host tag</th>
    <th colspan="13">Target tag</th>
</tr>
<tr>
    <th><code>py</code><br/><code>314t</code></th>
    <th><code>py</code><br/><code>313t</code></th>
    <th><code>py</code><br/><code>314</code></th>
    <th><code>py</code><br/><code>313</code></th>
    <th><code>py</code><br/><code>312</code></th>
    <th><code>py</code><br/><code>311</code></th>
    <th><code>py</code><br/><code>310</code></th>
    <th><code>py</code><br/><code>39</code></th>
    <th><code>py</code><br/><code>38</code></th>
    <th><code>py</code><br/><code>37</code></th>
    <th><code>py</code><br/><code>36</code></th>
    <th><code>py</code><br/><code>35</code></th>
    <th><code>py</code><br/><code>27</code></th>
</tr>
</thead>
<tbody>
<!-- docsub: begin -->
<!-- docsub: exec uv run python docsubfile.py '>=20' -->
<tr><th><code>py314t</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py313t</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py313</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py312</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py311</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py310</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py39</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py38</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py37</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<!-- docsub: end -->
</tbody>
</table>

## For `virtualenv>=20,<20.27`

<table>
<thead>
<tr>
    <th rowspan="2">Host tag</th>
    <th colspan="13">Target tag</th>
</tr>
<tr>
    <th><code>py</code><br/><code>314t</code></th>
    <th><code>py</code><br/><code>313t</code></th>
    <th><code>py</code><br/><code>314</code></th>
    <th><code>py</code><br/><code>313</code></th>
    <th><code>py</code><br/><code>312</code></th>
    <th><code>py</code><br/><code>311</code></th>
    <th><code>py</code><br/><code>310</code></th>
    <th><code>py</code><br/><code>39</code></th>
    <th><code>py</code><br/><code>38</code></th>
    <th><code>py</code><br/><code>37</code></th>
    <th><code>py</code><br/><code>36</code></th>
    <th><code>py</code><br/><code>35</code></th>
    <th><code>py</code><br/><code>27</code></th>
</tr>
</thead>
<tbody>
<!-- docsub: begin -->
<!-- docsub: exec uv run python docsubfile.py '>=20,<20.27' -->
<tr><th><code>py314t</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py313t</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py313</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py312</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py311</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py310</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py39</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py38</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<tr><th><code>py37</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>🚫</td><td>🚫</td><td>🚫</td></tr>
<!-- docsub: end -->
</tbody>
</table>

## For `virtualenv>=20,<20.22`

<table>
<thead>
<tr>
    <th rowspan="2">Host tag</th>
    <th colspan="13">Target tag</th>
</tr>
<tr>
    <th><code>py</code><br/><code>314t</code></th>
    <th><code>py</code><br/><code>313t</code></th>
    <th><code>py</code><br/><code>314</code></th>
    <th><code>py</code><br/><code>313</code></th>
    <th><code>py</code><br/><code>312</code></th>
    <th><code>py</code><br/><code>311</code></th>
    <th><code>py</code><br/><code>310</code></th>
    <th><code>py</code><br/><code>39</code></th>
    <th><code>py</code><br/><code>38</code></th>
    <th><code>py</code><br/><code>37</code></th>
    <th><code>py</code><br/><code>36</code></th>
    <th><code>py</code><br/><code>35</code></th>
    <th><code>py</code><br/><code>27</code></th>
</tr>
</thead>
<tbody>
<!-- docsub: begin -->
<!-- docsub: exec uv run python docsubfile.py '>=20,<20.22' -->
<tr><th><code>py314t</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<tr><th><code>py313t</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<tr><th><code>py313</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<tr><th><code>py312</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<tr><th><code>py311</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<tr><th><code>py310</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<tr><th><code>py39</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<tr><th><code>py38</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<tr><th><code>py37</code></th><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td></tr>
<!-- docsub: end -->
</tbody>
</table>

# Authors

* [Michael Makukha](https://github.com/makukha)

This package is a part of [multipython](https://github.com/makukha/multipython) project.


## License

[MIT License](https://github.com/makukha/caseutil/blob/main/LICENSE)


# Changelog

Check repository [CHANGELOG.md](https://github.com/makukha/virtualenv-multipython/tree/main/CHANGELOG.md)
