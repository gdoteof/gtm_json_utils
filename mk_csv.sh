#!/bin/bash

usage(){
  echo "Prints tracking id for all tags of a given folder"
  echo "$0 GTM-XXXX.json folder_id";
  echo "Note, you can get the folder ID by using ./list_folders.sh"
  exit 1
}

require_jq(){
  echo "$0 Requires the json parsing utility jq"
  echo "See https://stedolan.github.io/jq/ or install with your favorite package manager"
  exit 1
}

[ $# -lt 1 ] && {
  usage
}

if ! [ -x "$(command -v jq)" ]; then
  require_jq
fi

  

#cat $1 | jq '.containerVersion.tag | .[] | 
# (.parameter | .[]? | select(.key =="eventValue") | .value? // " ") as $value 
#| 
#  {
#    name : .name, 
#    category: .parameter | .[]? | select(.key =="eventCategory") | .value, 
#    action: .parameter | .[]? | select(.key =="eventAction") | .value, 
#    label: .parameter | .[]? | select(.key =="eventLabel") | .value, 
#    value: $value
#}'

cat $1 | jq  -r '.containerVersion.tag | map({name} + (.parameter | from_entries)) | 
   .[] | select(has("eventLabel") or has("eventValue") or has("eventCategory"))'
