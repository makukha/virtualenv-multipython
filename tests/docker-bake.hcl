variable "CASES" {
  default = [
    # NOTE: py20 is always missing in multipython image

    # NOTE: In tests without virtualenv version downpin, py37 should also be failing,
    #   because virtualenv does not support Python 3.7 starting from v20.27.
    #   However, it is still capable to detect 3.7 interpreter, and we use failed tags
    #   list "py20 py27 py35 py36" (without "py37").
    #   One day virtualenv will in fact drop 3.7 support, this test will fail,
    #   and "py37" should be added back to the list of failing targets.

    {tag="py314t", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py314t", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py314t", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

    {tag="py313t", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py313t", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py313t", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

    {tag="py313", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py313", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py313", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

    {tag="py312", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py312", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py312", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

    {tag="py311", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py311", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py311", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

    {tag="py310", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py310", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py310", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

    {tag="py39", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py39", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py39", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

    {tag="py38", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py38", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py38", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

    {tag="py37", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20"},  # be ready to fail "py37"
    {tag="py37", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37", fail="py36 py35 py27", venv=">=20,<20.27"},
    {tag="py37", pass="py314t py313t py314 py313 py312 py311 py310 py39 py38 py37 py36 py35 py27", fail="", venv=">=20,<20.22"},

  ]
}

target "default" {
  dockerfile = "tests/Dockerfile"
  context = "."
  args = {
    CASE_NAME = CASE["tag"],
    TOX_TAG = CASE["tag"],
    TAGS_PASSING = CASE["pass"],
    TAGS_NOTFOUND = "${CASE["fail"]} py20",  # always missing in multipython
    VIRTUALENV_PIN = CASE["venv"],
  }
  matrix = {
    CASE = CASES
  }
  name = "test_${CASE["tag"]}_${regex_replace(CASE["venv"], "[^0-9]", "_")}"
  output = ["type=cacheonly"]
}

