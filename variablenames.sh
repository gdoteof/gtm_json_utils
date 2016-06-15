#!/bin/bash

usage(){
  echo "Prints all trigger names for export from GTM"
  echo "$0 GTM-XXXX.json";
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
  
cat $1 | jq '.containerVersion.variable | .[] .name'

