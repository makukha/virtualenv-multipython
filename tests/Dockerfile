# build sample package

FROM python:3.12-slim-bookworm AS build
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
COPY tests/sample /sample
WORKDIR /sample/pkg_hatch
RUN uv build
WORKDIR /proj

# base

FROM makukha/multipython:unsafe AS base
SHELL ["/bin/bash", "-o", "errexit", "-o", "errtrace", "-o", "nounset", "-o", "pipefail", "-c"]
COPY dist /proj/dist
COPY tests/test_*.sh /proj/tests/
WORKDIR /proj/tests
# args
ARG HOST_TAG
ARG TARGET_TAGS_PASSING
ARG TARGET_TAGS_NOTFOUND
ARG VIRTUALENV_PIN
# envs
ENV HOST_TAG="${HOST_TAG}"
ENV TARGET_TAGS_PASSING="${TARGET_TAGS_PASSING}"
ENV TARGET_TAGS_NOTFOUND="${TARGET_TAGS_NOTFOUND}"
ENV VIRTUALENV_PIN="${VIRTUALENV_PIN}"

# targets

FROM base AS virtualenv
RUN <<EOT
    PIP="$(py bin --path "$HOST_TAG") -m pip"
    $PIP install "virtualenv$VIRTUALENV_PIN"
    $PIP install --no-index --find-links=/proj/dist virtualenv-multipython
    bash test_virtualenv.sh
EOT

FROM base AS tox4
COPY tests/tox.ini /proj/tests/
RUN --mount=type=bind,from=build,source=/sample,target=/sample <<EOT
    PIP="$(py bin --path "$HOST_TAG") -m pip"
    $PIP install "virtualenv$VIRTUALENV_PIN" "tox>=4,<5"
    $PIP install --no-index --find-links=/proj/dist virtualenv-multipython
    bash test_tox4.sh
EOT
