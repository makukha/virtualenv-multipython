#!/usr/bin/env bash
set -eEux -o pipefail

PYTHON="$(py bin --path "${HOST_TAG}")"

# verify tag coverage
# shellcheck disable=SC2001
INPUT_TAGS="$(sed 's/ /\n/g' <<<"$TARGET_TAGS_PASSING $TARGET_TAGS_NOTFOUND" | sort | xargs)"
IMAGE_TAGS="$(py ls --tag | sort | xargs)"
[ "$INPUT_TAGS" = "py20 $IMAGE_TAGS" ]

# test passing tags
for TAG in $TARGET_TAGS_PASSING; do
  $PYTHON -m virtualenv -p "$TAG" --no-seed --with-traceback "/tmp/$TAG"
  [ "$(py tag "/tmp/$TAG/bin/python")" = "$TAG" ]
done

# test failing tags
for TAG in $TARGET_TAGS_NOTFOUND; do
  [[ "$($PYTHON -m virtualenv -p "$TAG" "/tmp/$TAG" 2>&1)" == *"RuntimeError: failed to find interpreter "* ]]
  [ ! -d "/tmp/$TAG" ]
done

# status
echo "TEST CASE PASSED: ${HOST_TAG} ${VIRTUALENV_PIN}" >&2
