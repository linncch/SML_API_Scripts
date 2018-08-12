#!/bin/bash
# This script calls Smartling authentication API to get new access token and fresh token.
source assets.sh

refreshURL="https://api.smartling.com/auth-api/v2/authenticate/refresh"
params=(-d '{"refreshToken": "'"$refreshToken"'"}')
headers=(
	-H "cache-control: no-cache" 
	-H "content-type: application/json"
)

function refresh {
	curl --silent -X POST "${headers[@]}" "${params[@]}" "$refreshURL"
}

# Get response code
response=$(refresh "$refreshToken")
responseCode=$(echo "$response" | jq -r '.response.code')

# Save response to file only if POST succeeds
if [[ "$responseCode" = "SUCCESS" ]]
then
		echo "$response" > tokens.json
		echo -e $green"Your refreshed tokens have been saved in \"tokens.json\"."$none
else
		echo "$response"
fi
