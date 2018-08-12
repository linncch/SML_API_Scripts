#!/bin/bash
# This script uploads a context image via Smartling context API. 
source assets.sh

# Get user input for image to upload
echo -n "Please type the path to your iamge and press [ENTER]: "
read filePath

# Get file extension
filename=$(get_file_name "$filePath")
fileExtension=$(get_file_extension "$filename")

# Check file type
if ! is_supported_context_type "$fileExtension"
then
		echo "Image format not supported. Please select png or jpg images."
		exit
fi

# Post request
contextUploadURL="https://api.smartling.com/context-api/v2/projects/${projectId}/contexts"
headers=(
	  -H "authorization: Bearer $accessToken" 
	  -H "cache-control: no-cache" 
	  -H "content-type: multipart/form-data" 
)
params=(
	  -F "content=@$filePath;type=image/png"
)

function uploadContext {
	curl -X POST "${headers[@]}" "${params[@]}" "$contextUploadURL"
}

# Get response code
response=$(uploadContext "$filePath")
responseCode=$(echo "$response" | jq -r '.response.code')

# Save response to file only if POST succeeds
if [[ "$responseCode" = "SUCCESS" ]]
then
		echo "$response" >> context.json
		echo -e $green"Your context image \"$filename\" has been uploaded. Its contextUid has been saved in \"context.json\"."$none
else
		echo $response
fi


