#!/usr/bin/env bash
set -Eeu

readonly REGEX="image_name\": \"(.*)\""
readonly JSON=`cat docker/image_name.json`
[[ ${JSON} =~ ${REGEX} ]]
readonly IMAGE_NAME="${BASH_REMATCH[1]}"

# Fails when what the image holds is not what is named here. xunit is checked
# as well as dotnet because the start-point's manifest.json shows its version
# to the learner, and a version shown that the image does not hold is a lie.
check_version()
{
  local -r what="${1}"
  local -r expected="${2}"
  local -r actual="$(docker run --rm --interactive ${IMAGE_NAME} sh -c "${3}")"

  if echo "${actual}" | grep --quiet "${expected}"; then
    echo "VERSION CONFIRMED as ${what} ${expected}"
  else
    echo "VERSION EXPECTED: ${what} ${expected}"
    echo "VERSION   ACTUAL: ${actual}"
    exit 42
  fi
}

check_version dotnet 10.0.103 'dotnet --version'
check_version xunit 4.0.0 'ls /home/sandbox/.nuget/packages/xunit.v3'
