# NowSecure GitLab CI

This is the source repository to build the docker image available at https://hub.docker.com/repository/docker/nowsecure/gitlab-ci to be used within GitLab CI. 

This image gives you the ability to perform automatic mobile app security testing for Android and iOS mobile apps through the NowSecure test engine.

## Summary

Purpose-built for mobile app teams, NowSecure provides fully automated, mobile appsec testing coverage (static+dynamic+behavioral tests) optimized for the dev pipeline. Because NowSecure tests the mobile app binary post-build from Gitlab, it can test software developed in any language and provides complete results including newly developed code, 3rd party code, and compiler/operating system dependencies. With near zero false positives, NowSecure pinpoints real issues in minutes, with developer fix details, and routes tickets automatically into ticketing systems, such as Jira. NowSecure is frequently used to perform security testing in parallel with functional testing in the dev cycle. Requires a license for and connection to the NowSecure software.
 https://www.nowsecure.com

## Sample Usage

You should pass values for `AUTO_GROUP` and `AUTO_TOKEN` in via CI/CI environment variable in GitLab CI/CD Pipeline Settings instead in the Job Definition for security reasons.

```yaml
nowsecure:
  stage: test
  image: nowsecure/gitlab-ci:latest
  variables:
    AUTO_GROUP: 00000000-0000-0000-0000-000000000000
    AUTO_TOKEN: xxx
    BINARY_FILE: /path/to/artifact/apk/or/ipa/file
  script:
    - nowsecure.sh
```


## Getting Started

### Access token
Generate token as described in https://nowsecurehelp.zendesk.com/hc/en-us/articles/360034149691 (Note: customer sign in is required to access this resource). This token will be specified by environment variable `AUTO_TOKEN`.

### Required Environment variables

- `AUTO_TOKEN=default_token` - Specifies auto token from your account
- `AUTO_GROUP=default_group` - Specifies group for your account
- `BINARY_FILE=default_binary` - Path to Android apk or IOS ipa - this file must be mounted via volume for the access

### Optional Environment variables

Following are optional parameters that can be set from environment variables:

- `MAX_WAIT=nn (default 30)` - Default max wait in minutes for the mobile analysis
- `MAX_SCORE=nn (default 50)` - Minimum score the app must have otherwise it would fail
- `ARTIFACTS_DIR=/home/gradle/artifacts` - Specifies artifacts directory where json files are stored


## Creating Gitlab-CI Pipeline:
Here is a sample config that you can save under `.gitlab-ci.yml` in your mobile project. Please read https://docs.gitlab.com/ee/ci/pipelines/pipeline_architectures.html for more information on Gitlab Pipeline.
```yaml
nowsecure:
  stage: test
  image: nowsecure/gitlab-ci:latest
  variables:
    BINARY_FILE: test.apk
  script:
    - nowsecure.sh

stages:
  - build
  - test
  - deploy

image: alpine

build_a:
  stage: build
  script:
    - echo "Building...."

test_a:
  stage: test
  script:
    - echo "Testing..."

deploy_a:
  stage: deploy
  script:
    - echo "Deploying..."
```

## Adding Environment variables in Gitlab Pipeline
Select Settings option from your Gitlab project and then jump to `Variables` section to add environment variables for your pipeline, e.g.

![Gitlab Environment Add Variable](/images/gitlab_1.png)

![Gitlab Environment Variables](/images/gitlab_2.png)


## Submitting CI/CD Submitting Pipeline
The CI/CD will be run when you check-in new changes or you can select CI/CD option from your Gitlab project and then click on `Run Pipeline` to submit a pipeline, e.g. 

![Submit Pipeline](/images/gitlab_3.png)

![View Pipeline](/images/gitlab_4.png)
