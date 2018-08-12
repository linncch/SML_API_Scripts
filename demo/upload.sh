#!/bin/bash
# The script uploads a single file to Smartling.
source assets.sh

# Get user input for file path and file type
echo -n "Please type the path to your file and press [ENTER]: "
read filePath
echo -n "Please enter the file type and press [ENTER]: "
read fileType

# Check file type
if ! is_supported_file_type "$fileType"
then
    echo "The file type is not supported."
    exit
fi

# URL
fileUploadURL="https://api.smartling.com/files-api/v2/projects/${projectId}/file"
# Change HTTP request header here
headers=(
    -H "authorization: Bearer $accessToken" 
    -H "cache-control: no-cache" 
    -H "content-type: multipart/form-data" 
)
# Change request params here
params=(
    -F "file=@$filePath" 
    -F "fileUri=$filePath" 
    -F "fileType=$fileType" 
    -F "authorize=true" 
    -F "smartling.placeholder_format_custom=$custom_placeholder"
)

# Post request
function uploadFile {
  curl -X POST "${headers[@]}" "${params[@]}" "$fileUploadURL"
}

# Get response code
response=$(uploadFile)
responseCode=$(echo "$response" | jq -r '.response.code')

# Notify if POST succeeds
if [[ "$responseCode" = "SUCCESS" ]]
then
    echo -e $green"File uploaded."$none
fi

echo $response