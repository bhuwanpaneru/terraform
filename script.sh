#!/bin/bash 

eval "$(jq -r '@sh "GROUP_NAME=\(.rgName)"')"
result=$(az group exists -n $GROUP_NAME)

jq -n --arg exists "$result" '{"exists":$exists}'
