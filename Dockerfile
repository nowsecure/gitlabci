FROM openjdk:8
# plugin version from https://github.com/nowsecure/auto-circleci-plugin/releases
ENV PLUGIN_VERSION 1.2.0e
#
# Download nowsecure plugin source
RUN mkdir -p /usr/local/share/nowsecure
RUN curl -Ls https://github.com/nowsecure/auto-circleci-plugin/archive/${PLUGIN_VERSION}.tar.gz | tar -xzf - -C /usr/local/share/nowsecure
RUN cp /usr/local/share/nowsecure/auto-circleci-plugin-${PLUGIN_VERSION}/bin/nowsecure.sh /usr/local/bin/nowsecure.sh

ENV PLUGIN_JAR /usr/local/share/nowsecure/auto-circleci-plugin-${PLUGIN_VERSION}/dist/all-in-one-jar-${PLUGIN_VERSION}.jar
#
### Execute script to execute nowsecure plugin
### You can customize plugin using following environment variables:
### AUTO_TOKEN - (Required) Specify auto token from your account
### AUTO_GROUP - (Required) Specify group for your account
### BINARY_FILE - (Required) Path to Android apk or IOS ipa - this file must be mounted via volume for the access
### MAX_WAIT - (Optional) Default max wait in minutes for the mobile analysis
### MIN_SCORE - (Optional) Minimum score the app must have otherwise it would fail
### ARTIFACTS_DIR - (Optional) artifacts directory where json files are stored
#

CMD /usr/local/bin/nowsecure.sh

## EXAMPLE FOR EXECUTING DOCKER IMAGE
# docker run -v ~/Desktop/apk:/source -v /tmp:/artifacts -e AUTO_TOKEN=$AUTO_TOKEN -e AUTO_GROUP=$AUTO_GROUP -e BINARY_FILE=/source/test.apk -e ARTIFACTS_DIR=/artifacts -e MAX_WAIT=30 -e MIN_SCORE=50 -it --rm $IMAGE_ID
# If MIN_SCORE is higher than zero and security score is below that number, the docker job would fail, e.g.
# java.io.IOException: Test failed because score (45.0) is lower than threshold 50
