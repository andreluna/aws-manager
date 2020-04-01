#!/bin/bash

# Script para deleter um usuario da AWS
# uso:
# ./delete_user.sh <PROFILE> <USER-NAME>
# ./delete_user.sh homologation rick.sanchez

PROFILE=$1
USERNAME=$2

function list_user_groups() {
  group_list=$(aws --profile $PROFILE iam list-groups-for-user --user-name \
  $USERNAME | jq .'Groups[]' | jq .GroupName | sed s/\"//g)

  for line in $group_list
  do
    echo $line
  done
}

function list_access_key() {
  access_key_list=$(aws --profile $PROFILE iam list-access-keys --user-name \
  $USERNAME | jq .'AccessKeyMetadata[]' | jq .AccessKeyId | sed s/\"//g)

  for line in $access_key_list
  do
    echo $line
  done
}

function list_policies() {
  attached_policies_list=$(aws --profile $PROFILE \
  iam list-attached-user-policies --user-name $USERNAME | jq .'AttachedPolicies[]' \
  | jq .PolicyArn | sed s/\"//g)

  for line in $attached_policies_list
  do
    echo $line
  done
}

echo "-------------------------------------------------------------"
echo "Groups from user $USERNAME:"
list_user_groups
echo "-------------------------------------------------------------"
echo "Access Key from user $USERNAME: "
list_access_key
echo "-------------------------------------------------------------"
echo "Attached Policies from user $USERNAME: "
list_policies
echo "-------------------------------------------------------------"

echo -n "Delete user - $USERNAME ? [ Yes(Y) or No(N) ]"
read response

if [ $response = 'Y' ]
then
  # remove user from groups
  for group in $group_list; do
   aws --profile $PROFILE iam remove-user-from-group --user-name \
      $USERNAME --group-name $group
   echo "User $USERNAME removed from group $group"
  done
  # remove access keys
  for key_id in $access_key_list; do
    aws --profile $PROFILE iam delete-access-key --access-key-id \
        $key_id --user-name $USERNAME
    echo "User $USERNAME deleted key ID $key_id"
  done
  # remove attached policies
  for policy_arn in $attached_policies_list; do
    aws --profile $PROFILE iam detach-user-policy --user-name \
        $USERNAME --policy-arn $policy_arn
    echo "Policie removed from user $USERNAME"
  done
  # delete user
  aws --profile $PROFILE iam delete-login-profile --user-name $USERNAME
  echo "login-profile deleted from user $USERNAME"
  aws --profile $PROFILE iam delete-user --user-name $USERNAME
  echo "User $USERNAME deleted from AWS ACCOUNT $PROFILE"
else
  exit 0
fi
