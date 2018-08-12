#!/bin/bash

# http://help.smartling.com/developers/api/v2/files/upload-file/
SUPPORTED_FILE_TYPES=(android ios gettext html javaProperties yaml xliff xml json docx pptx xlsx idml qt resx plaintext csv stringsdict)

# http://help.smartling.com/developers/api/v2/context/upload-context/
SUPPORTED_CONTEXT_TYPES=(png jpg)

# placeholder regex in the format: (regex1)|(regex2)|(regex3)
custom_placeholder="(\{\{.+?\}\})|(@@.+?@@)"

filename=$(basename "$filePath")
fileExtension="${filename##*.}"

# Get values from json files using jq
accessToken=($(jq -r '.response.data.accessToken' tokens.json)) 
refreshToken=($(jq -r '.response.data.refreshToken' tokens.json)) 
projectId=($(jq -r '.projectId' hu-post.json)) 
contextUid=($(jq -r '.response.data.contextUid' context.json)) 

# FUNCTIONS
function get_file_name {
	local filePath="$1"
	filename=$(basename "$filePath")
	echo "$filename"
}

function get_file_extension {
	local filename="$1"
	echo "${filename##*.}"
}

# Style messages
blue=$(tput setab 0; tput setaf 4)
green=$(tput setab 0; tput setaf 2)
none=$(tput sgr0)


#https://github.com/Smartling/api-scripts/blob/master/bash/common.sh
function array_contains_value {
    local el;
    for el in "${@:2}"; do
        [[ "$el" == "$1" ]] && return 0
    done
    return 1
}	
function is_supported_file_type {
    array_contains_value "$1" "${SUPPORTED_FILE_TYPES[@]}"
    return $?
}	
function is_supported_context_type {
    array_contains_value "$1" "${SUPPORTED_CONTEXT_TYPES[@]}"
    return $?
}