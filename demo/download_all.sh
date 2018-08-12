#!/bin/bash
# This script downloads files as zip via Smartling file API.
source assets.sh \

# Get user input for fileUri and zip name
echo -n "Please enter the fileUri and press [ENTER]: "
read fileUri

echo -n "Please name the download file (without zip extension) and press [ENTER]: "
read zipName

curl -X -GET \
  "https://api.smartling.com/files-api/v2/projects/${projectId}/locales/all/file/zip?fileUri=${fileUri}" \
  -H "authorization: Bearer $accessToken" \
  -H "cache-control: no-cache" \
  -H "content-type: application/zip" \
  -o "$zipName.zip"
