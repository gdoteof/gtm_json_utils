#!/bin/bash

usage(){
  echo "Creates a csv file from GTM json dump containing all GA events"
  echo "$0 GTM-XXXX.json folder_id";
  echo "Note, you can get the folder ID by using ./list_folders.sh"
  exit 1
}

require_jq(){
  echo "$0 Requires the json parsing utility jq"
  echo "See https://stedolan.github.io/jq/ or install with your favorite package manager"
  exit 1
}

require_json2csv(){
  echo "$0 Requires the json2csv utility"
  echo "See https://github.com/zemirco/json2csv "
  echo "HINT-- npm install json2csv -g"
  exit 1
}

[ $# -lt 1 ] && {
  usage
}

if ! [ -x "$(command -v jq)" ]; then
  require_jq
fi

if ! [ -x "$(command -v json2csv)" ]; then
  require_json2csv
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

cat $1 | jq  -r '[.containerVersion.tag | map({name} + (.parameter | from_entries)) | 
   .[] | select(has("eventLabel") or has("eventValue") or has("eventCategory"))]' | json2csv -f name,eventCategory,eventAction,eventLabel,eventValue,trackingId 
