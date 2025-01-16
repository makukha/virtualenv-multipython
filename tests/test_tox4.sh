#!/usr/bin/env bash
set -eEux -o pipefail

PYTHON="$(py bin --path "${HOST_TAG}")"
TOX="$PYTHON -m tox -vvv"

# verify tag coverage
# shellcheck disable=SC2001
INPUT_TAGS="$(sed 's/  */\n/g' <<<"$TARGET_TAGS_PASSING $TARGET_TAGS_NOTFOUND" | sort | xargs)"
IMAGE_TAGS="$(py ls --tag | sort | xargs)"
[ "$INPUT_TAGS" = "py20 $IMAGE_TAGS" ]

# prepare env vars referenced in tox.ini
export ENVS_PASSING="${TARGET_TAGS_PASSING// /,}"
export ENVS_NOTFOUND="${TARGET_TAGS_NOTFOUND// /,}"
export ENVS="${INPUT_TAGS// /,}"

# test passing tags
$TOX run -m passing --installpkg=/sample/pkg_hatch/dist/pkg_hatch-1-py2.py3-none-any.whl

# test failing tags
for TAG in $TARGET_TAGS_NOTFOUND; do
  [[ "$($TOX run -e $TAG)" == *" failed with could not find python "* ]]
done

# status
echo "TEST CASE PASSED: ${HOST_TAG} ${VIRTUALENV_PIN}" >&2
