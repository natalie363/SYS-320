#! /bin/bash

allLogs=""
curlLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f7 | sort | uniq -c)
}

function getCurlLogs(){
curlLogs=$(cat "$file" | grep "curl" | cut -d' ' -f1,12 | sort | uniq -c)
}

getCurlLogs
#getAllLogs

echo "$curlLogs"
