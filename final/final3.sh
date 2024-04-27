#! /bin/bash

report=$(cat "$1")

echo "<html>" > report.html 
echo "<header> <h1>Logs with IOCs</h1> </header>" >> report.html
echo "<body>" >> report.html
echo "<table border=1>" >> report.html

echo "$report" | while read -r line;
do

echo "<tr>" >> report.html
lineip=$(echo "$line" | cut -d " " -f1)
linetime=$(echo "$line" | cut -d " " -f2)
linesearch=$(echo "$line" | cut -d " " -f3)

echo "<td>$lineip</td>" >> report.html
echo "<td>$linetime</td>" >> report.html
echo "<td>$linesearch</td>" >> report.html

echo "</tr>" >> report.html

done

echo "</table>" >> report.html 
echo "</body>" >> report.html
echo "</html>" >> report.html

mv -f report.html /var/www/html
