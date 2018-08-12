#!/bin/bash
# This script automatically matches a Context Image against strings in the project using OCR
# and creates bindings for any found matches.
source assets.sh


# Post request
contextMatchURL="https://api.smartling.com/context-api/v2/projects/${projectId}/contexts/${contextUid}/match"
# Change HTTP request header here
headers=(
	-H "authorization: Bearer $accessToken" 
	-H "cache-control: no-cache" 
	-H "content-type: application/json"
)

function matchContext {
	curl -X POST "${headers[@]}" "$contextMatchURL"
}

# Get response code
response=$(matchContext)
responseCode=$(echo "$response" | jq -r '.response.code')

# Save response to file only if POST succeeds
if [[ "$responseCode" = "SUCCESS" ]]
then
    echo "$response" > bindings.json
	echo -e $green"Context match has been completed. You can find the binding information in \"bindings.json\"."$none
else
    echo $response
fi