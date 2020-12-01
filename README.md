
## Environment variables for Docker Execution

Following are required parameters that can be set from environment variables:
`AUTO_TOKEN=default_token` - Specifies auto token from your account

`AUTO_GROUP=default_group` - Specifies group for your account

`BINARY_FILE=default_binary` - Path to Android apk or IOS ipa - this file must be mounted via volume for the access


Following are optional parameters that can be set from environment variables:

`MAX_WAIT=nn (default 30)` - Default max wait in minutes for the mobile analysis

`MAX_SCORE=nn (default 50)` - Minimum score the app must have otherwise it would fail

`ARTIFACTS_DIR=/home/gradle/artifacts` - Specifies artifacts directory where json files are stored


Example:
Use environment variables for now-secure token and group:
export AUTO_GROUP="aaa"
export AUTO_TOKEN="eyxx"
Then execute the docker plugin:
docker build -t auto-circle-plugin .
docker run -v ~/Desktop/apk:/source -v /tmp:/artifacts -e AUTO_TOKEN=$AUTO_TOKEN -e AUTO_GROUP=$AUTO_GROUP -e BINARY_FILE=/source/fire.apk -e ARTIFACTS_DIR=/artifacts -e MAX_WAIT=30 -e MIN_SCORE=50 -it --rm auto-circle-plugin
