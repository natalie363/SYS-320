
#! /bin/bash

logFile=$(cat "$1")
iocFile=$(cat "$2")

neededInfo=$(echo "$logFile" | cut -d " " -f 1,4,7 | tr -d '[')
:> reportdraft.txt
:> report.txt

echo "$neededInfo" | while read -r line;
do
	pageOnly=$(echo "$line" | cut -d " " -f 3)
	infoLine="$line"

	echo "$iocFile" | while read -r line;
	do
		if [[ "$pageOnly" == *"$line"* ]]; then
			echo "$infoLine" >> reportdraft.txt
		fi
	done
done

cat reportdraft.txt | uniq >> report.txt
rm reportdraft.txt
