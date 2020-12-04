# NowSecure GitLab CI

This is the source repository to build the docker image available at https://hub.docker.com/repository/docker/nowsecure/gitlab-ci to be used within GitLab CI. 

This image gives you the ability to perform automatic mobile app security testing for Android and iOS mobile apps through the NowSecure test engine.

## Summary

Purpose-built for mobile app teams, NowSecure provides fully automated, mobile appsec testing coverage (static+dynamic+behavioral tests) optimized for the dev pipeline. Because NowSecure tests the mobile app binary post-build from CircleCI, it can test software developed in any language and provides complete results including newly developed code, 3rd party code, and compiler/operating system dependencies. With near zero false positives, NowSecure pinpoints real issues in minutes, with developer fix details, and routes tickets automatically into ticketing systems, such as Jira. NowSecure is frequently used to perform security testing in parallel with functional testing in the dev cycle. Requires a license for and connection to the NowSecure software.
 https://www.nowsecure.com

## Job Parameters

All of these can be and should be passed in as variables to GitLab CI jobs.

- `auto_token` **Required** - Authentication token for API. Visit https://docs.nowsecure.com/auto/integration-services/jenkins-integration to generate token.
- `auto_group` **Required** The Group ID that the testing should be submitted against.
- `auto_url` (default: https://lab-api.nowsecure.com) API location, this generally should not be changed
- `max_wait` (default: 30) Maximum wait in minutes until security test is completed. To skip the wait, set to 0.
- `min_score` (default: 50) Minimum score the app must have otherwise the job will fail
- `auto_show_status_messages` (default: true) Specify flag to show status messages from automation testing. Set to false to hide status messages

## Sample Usage

You should pass `auto_token` in via CI/CI variable in GitLab Settings instead in the Job Definition for security reasons.

```yaml
nowsecure-auto:
  stage: test
  image: nowsecure/auto-gitlab-plugin:v1.1.0
  variables:
    auto_group: 00000000-0000-0000-0000-000000000000
    binary_file: /path/to/artifact/apk/or/ipa/file
  script:
    - bash run-tests
```

Note that you will generate mobile binary using gradle, Makefile, Fastlane or other tools instead of copying file but it shows how binary file will be created and then passed to the Auto CircleCI Orb for security analysis.

## Getting Started

### Access token

Generate token as described on https://docs.nowsecure.com/auto/integration-services/jenkins-integration. This token will be specified by environment variable AUTO_TOKEN.

## Environment variables

- `AUTO_TOKEN=default_token` - Specifies auto token from your account
- `AUTO_GROUP=default_group` - Specifies group for your account
- `BINARY_FILE=default_binary` - Path to Android apk or IOS ipa - this file must be mounted via volume for the access

## Optional

Following are optional parameters that can be set from environment variables:

- `MAX_WAIT=nn (default 30)` - Default max wait in minutes for the mobile analysis
- `MAX_SCORE=nn (default 50)` - Minimum score the app must have otherwise it would fail
- `ARTIFACTS_DIR=/home/gradle/artifacts` - Specifies artifacts directory where json files are stored
