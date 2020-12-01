#!/bin/bash -e
###
# Nowsecure Plugin to upload binary file, run assessment and retrieve scores
# This script will fail if the job fails or score is below minimum threshold.
###

if [[ -z "${PLUGIN_VERSION}" ]]; then
  PLUGIN_VERSION="1.2.0-rc2"
fi

if [[ -z "${PLUGIN_JAR}" ]]; then
  BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  PLUGIN_JAR=${BIN_DIR}/../dist/all-in-one-jar-${PLUGIN_VERSION}.jar
fi

if [[ -z "${AUTO_URL}" ]]; then
  AUTO_URL="https://lab-api.nowsecure.com"
fi

if [[ -z "${ARTIFACTS_DIR}" ]]; then
  ARTIFACTS_DIR="/tmp/nowsecure/artifacts"
  mkdir -p ${ARTIFACTS_DIR}
fi

if [[ -z "${AUTO_TOKEN}" ]]; then
  echo "Please specify nowsecure API token using environment variable AUTO_TOKEN"
  exit 1
fi

if [[ -z "${AUTO_GROUP}" ]]; then
  echo "Please specify nowsecure group using environment variable AUTO_GROUP"
  exit 1
fi

if [[ -z "${BINARY_FILE}" ]]; then
  echo "Please specify binary file to test using environment variable BINARY_FILE"
  exit 1
fi

if [[ -z "${MAX_WAIT}" ]]; then
  MAX_WAIT=60
fi

if [[ -z "${MIN_SCORE}" ]]; then
  MIN_SCORE=50
fi

if [[ -z "${SHOW_STATUS_MESSAGES}" ]]; then
  SHOW_STATUS_MESSAGES=true
fi

exec java -jar ${PLUGIN_JAR} --plugin-name circleci-nowsecure-auto-security-test --plugin-version ${PLUGIN_VERSION} --auto-url $AUTO_URL --auto-token $AUTO_TOKEN --auto-dir $ARTIFACTS_DIR --auto-file $BINARY_FILE --auto-group $AUTO_GROUP --auto-wait $MAX_WAIT --auto-score $MIN_SCORE --auto-show-status-messages $SHOW_STATUS_MESSAGES --debug
