#! /bin/bash

file="/var/log/apache2/access.log"
results=$(cat "$file" | grep "GET /page2.html" | cut -d' ' -f1,7 | tr -d "/")
echo "$results"
