#!/bin/bash

function check() {
response=$(curl -s -k -X $'POST' -H $'Host: surokkha.gov.bd' -H $'Authorization: Bearer TOKEN_HERE' \
--data-binary $'{
        "basic_type_id":"30",
        "basic_sub_type_id":"",
        "passport_no":"'"$1"'",
        "country_id":"BD",
        "dob":"'"$2"'"
}' $'https://surokkha.gov.bd/manage/api/foreigner-verify')

msg=$(echo $response | jq '.response.message_en')
result=$(echo $response | jq '.response.result')

if $result ;
then
        name=$(echo $response | jq '.response.data.name')
        versity=$(echo $response | jq '.response.data.parent_office_name')
   echo "Your information is added. ${name} $versity" | /root/go/bin/notify
elif [ "$msg" == "\"You are already registered.\"" ];
then
        echo "$1 already registered!" | /root/go/bin/notify
else
        echo "$msg"
fi
}

check "bq0000000" "02/02/1997"
