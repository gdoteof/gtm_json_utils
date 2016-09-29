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

[ $# -lt 1 ] && {
  usage
}

if ! [ -x "$(command -v jq)" ]; then
  require_jq
fi

  


cat $1 | jq  '{containerVersion: .containerVersion | {accountId,container,containerId,containerVersionId,deleted,fingerprint,folder,trigger,
  variable, 
  tag: .tag, 
  exportFormatVersion, 
  exportTime}}'
