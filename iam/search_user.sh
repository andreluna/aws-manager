#!/bin/bash

# Script para buscar usuarios ja criados na AWS
# uso:
# ./search_user.sh <PROFILE> <USER-NAME>
# ./search_user homologation rick.sanchez

PROFILE=$1
USERNAME=$2

function list_users() {

  users_list=$(aws --profile $PROFILE iam list-users | jq .'Users[]' | jq .UserName)
  for line in $users_list
  do
    echo $line | egrep *$USERNAME* | sed s/\"//g
  done
}

list_users
