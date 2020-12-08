#!/bin/bash -e
###
# Nowsecure Plugin to upload binary file, run assessment and retrieve scores
# This script will fail if the job fails or score is below minimum threshold.
###

if [[ -z "${PLUGIN_VERSION}" ]]; then
  PLUGIN_VERSION="1.2.0-rc5"
fi

if [[ -z "${PLUGIN_JAR}" ]]; then
  BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  PLUGIN_JAR=${BIN_DIR}/../dist/all-in-one-jar-${PLUGIN_VERSION}.jar
fi

if [[ -z "${NOWSECURE_URL}" ]]; then
  NOWSECURE_URL="https://lab-api.nowsecure.com"
fi

if [[ -z "${NOWSECURE_ARTIFACTS_DIR}" ]]; then
  NOWSECURE_ARTIFACTS_DIR="/tmp/nowsecure/artifacts"
  mkdir -p ${NOWSECURE_ARTIFACTS_DIR}
fi

if [[ -z "${NOWSECURE_TOKEN}" ]]; then
  echo "Please specify nowsecure API token using environment variable NOWSECURE_TOKEN"
  exit 1
fi

if [[ -z "${NOWSECURE_GROUP}" ]]; then
  echo "Please specify nowsecure group using environment variable NOWSECURE_GROUP"
  exit 1
fi

if [[ -z "${NOWSECURE_BINARY_FILE}" ]]; then
  echo "Please specify binary file to test using environment variable NOWSECURE_BINARY_FILE"
  exit 1
fi

if [[ -z "${NOWSECURE_MIN_WAIT}" ]]; then
  NOWSECURE_MIN_WAIT=60
fi

if [[ -z "${NOWSECURE_MIN_SCORE}" ]]; then
  NOWSECURE_MIN_SCORE=50
fi

if [[ -z "${SHOW_STATUS_MESSAGES}" ]]; then
  SHOW_STATUS_MESSAGES=true
fi

exec java -jar ${PLUGIN_JAR} --plugin-name gitlab-nowsecure-auto-security-test --plugin-version ${PLUGIN_VERSION} --auto-url $NOWSECURE_URL --auto-token $NOWSECURE_TOKEN --auto-dir $NOWSECURE_ARTIFACTS_DIR --auto-file $NOWSECURE_BINARY_FILE --auto-group $NOWSECURE_GROUP --auto-wait $NOWSECURE_MIN_WAIT --auto-score $NOWSECURE_MIN_SCORE --auto-show-status-messages $SHOW_STATUS_MESSAGES --debug
