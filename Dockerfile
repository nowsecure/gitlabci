FROM openjdk:8
# plugin version from https://github.com/nowsecure/gitlabci/releases
ENV PLUGIN_VERSION 1.2.0-rc3
#
# Download nowsecure plugin source
RUN mkdir -p /usr/local/share/nowsecure
RUN curl -Ls https://github.com/nowsecure/gitlabci/archive/${PLUGIN_VERSION}.tar.gz | tar -xzf - -C /usr/local/share/nowsecure
RUN cp /usr/local/share/nowsecure/gitlabci-${PLUGIN_VERSION}/bin/nowsecure.sh /usr/local/bin/nowsecure.sh

ENV PLUGIN_JAR /usr/local/share/nowsecure/gitlabci-${PLUGIN_VERSION}/dist/all-in-one-jar-${PLUGIN_VERSION}.jar
#
### Execute script to execute nowsecure plugin
### You can customize plugin using following environment variables:
### NOWSECURE_TOKEN - (Required) Specify auto token from your account
### NOWSECURE_GROUP - (Required) Specify group for your account
### NOWSECURE_BINARY_FILE - (Required) Path to Android apk or IOS ipa - this file must be mounted via volume for the access
### NOWSECURE_MIN_WAIT - (Optional) Default max wait in minutes for the mobile analysis
### NOWSECURE_MIN_SCORE - (Optional) Minimum score the app must have otherwise it would fail
### NOWSECURE_ARTIFACTS_DIR - (Optional) artifacts directory where json files are stored
#

CMD /usr/local/bin/nowsecure.sh

## EXAMPLE FOR EXECUTING DOCKER IMAGE
# docker run -v ~/Desktop/apk:/source -v /tmp:/artifacts -e NOWSECURE_TOKEN=$NOWSECURE_TOKEN -e NOWSECURE_GROUP=$NOWSECURE_GROUP -e NOWSECURE_BINARY_FILE=/source/test.apk -e NOWSECURE_ARTIFACTS_DIR=/artifacts -e NOWSECURE_MIN_WAIT=30 -e NOWSECURE_MIN_SCORE=50 -it --rm $IMAGE_ID
# If NOWSECURE_MIN_SCORE is higher than zero and security score is below that number, the docker job would fail, e.g.
# java.io.IOException: Test failed because score (45.0) is lower than threshold 50
