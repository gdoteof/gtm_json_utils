#!/bin/bash

usage(){
  echo "Prints names and id for export from GTM"
  echo "$0 GTM-XXXX.json folder_id";
  echo "Note, you can get the folder ID by using ./list_folders.sh"
  exit 1
}

require_jq(){
  echo "$0 Requires the json parsing utility jq"
  echo "See https://stedolan.github.io/jq/ or install with your favorite package manager"
  exit 1
}

[ $# -lt 2 ] && {
  usage
}

if ! [ -x "$(command -v jq)" ]; then
  require_jq
fi

  
cat $1 | jq ".containerVersion.tag | .[] | select(.parentFolderId == \"$2\" ) | .parameter | .[] | select(.key == \"trackingId\")"
#cat $1 | jq ".containerVersion.tag | .[] | select(.parentFolderId == \"$2\" ) | .parameter | .[] | select(.key=='trackingId')"
