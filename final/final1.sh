#! /bin/bash

link="10.0.17.5/ioc.html"

#html body table tbody tr td

fullPage=$(curl -sL "$link")

toolOutput=$(echo "$fullPage" | xmlstarlet format --html --recover 2>/dev/null | xmlstarlet select --template --copy-of "//html//body//table//tr//td" 2>/dev/null)

echo "$toolOutput" | sed 's/<\/td>/\n/g' | sed -e 's/<td>//g' |  awk 'NR % 2 {print} !(NR % 2) && /pattern/ {print}' | sed '/^$/d' > ioc.txt
