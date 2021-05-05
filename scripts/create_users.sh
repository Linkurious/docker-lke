#!/bin/bash

set -o pipefail
set -e
set -u
#set -x

function usage
{
  echo "Usage:"
  echo "  -h help"
  echo "  -f file.csv"
  echo "  -c session cookie"
  echo "  -u api url"
  exit 0
}

function create_user
{
  local user_data
  local email
  local first_name
  local last_name
  local username
  local password
  local payload
  user_data="${1}"
  email=$(cut -d ',' -f 3 <<< "${user_data}")
  first_name=$(cut -d ',' -f 1 <<< "${user_data}")
  last_name=$(cut -d ',' -f 2 <<< "${user_data}")
  username="${first_name} ${last_name}"
  password=$(openssl rand -base64 14)
  payload="{\"email\":\"${email}\",\"username\":\"${username}\",\"password\":\"${password}\",\"groups\":[2]}"
  curl -q -L $debug -H 'content-type: application/json' -H "cookie: linkurious.session=${lke_session_cookie}" "${lke_api_url}/admin/users" --data-raw "${payload}"
  echo -e ""
  echo "${email},$password" >> "credentials_${user_file}"
}

##########
# Main
##########
debug=""
user_file=""
lke_api_url="https://lke.app.dev.linkurious.net/api"
# session cookie extracted from browser
lke_session_cookie=""
while getopts "c:u:f:dh" argument
do
  case $argument in
    f) user_file=$OPTARG;;
    c) lke_session_cookie=$OPTARG;;
    u) lke_api_url=$OPTARG;;
    d) debug='-vv';;
    h) usage;;
    *) usage;;
  esac
done

if [[ -z $user_file ]]; then
  echo "Missing user file"
  usage
fi

#jq -R -s -f scripts/csv2json.jq "${user_file}" > "${user_file}".json
while read -r user_data; do
  create_user "${user_data}"
done < "${user_file}"
