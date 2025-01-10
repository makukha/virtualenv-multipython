FROM makukha/multipython:unsafe
SHELL ["/bin/bash", "-o", "errexit", "-o", "errtrace", "-o", "nounset", "-o", "pipefail", "-c"]

COPY dist /test/dist
COPY tests/tox.ini /test/tests/
WORKDIR /test/tests

RUN <<EOT
    # remove version pre-installed with multipython
    python -m pip uninstall -y tox virtualenv-multipython
EOT

ARG TOX_TAG
ARG VIRTUALENV_PIN
RUN <<EOT
    set -eEux -o pipefail
    # install tox and current plugin version
    $(py bin --path "$TOX_TAG") -m pip install "tox>=4,<5" "virtualenv$VIRTUALENV_PIN" wheel
    $(py bin --path "$TOX_TAG") -m pip install ../dist/*.whl
EOT

# turn the plugin on
ENV VIRTUALENV_DISCOVERY=multipython

ARG CASE_NAME
ARG TAGS_PASSING
ARG TAGS_NOTFOUND
RUN <<EOT
    set -eEux -o pipefail
    echo_success () {
      echo "TEST CASE PASSED: ${CASE_NAME}" >&2
    }

    TOX="$(py bin --path "$TOX_TAG") -m tox"
    # make sure all tags mentioned
    IMAGE_TAGS="$(py ls --tag | sort | xargs)"
    TESTING_TAGS="$(sed 's/ /\n/g' <<<"$TAGS_PASSING $TAGS_NOTFOUND" | sed '/^py20$/d' | sort | xargs)"
    [ "$TESTING_TAGS" = "$IMAGE_TAGS" ]

    export ENVS_PASSING="$(tr ' ' , <<<"$TAGS_PASSING")"
    export ENVS_NOTFOUND="$(tr ' ' , <<<"$TAGS_NOTFOUND")"
    export ENVS="$(sed 's/  */,/g' <<<"$TAGS_PASSING $TAGS_NOTFOUND")"

    # passing
    $TOX run -m passing -v

    # not found
    for TAG in $TAGS_NOTFOUND; do
      [[ "$($TOX run -e $TAG)" == *" failed with could not find python "* ]]
    done

    echo_success
EOT
