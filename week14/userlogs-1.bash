#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}

#getLogins

function getFailedLogins(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
logline=$(cat "$authfile" | grep "authentication failure")
dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,3,16 | sed -e "s/user\=//")
echo "$dateAndUser"
}

#getFailedLogins

# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: natalie.eckles@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
echo -e "\n\n" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp natalie.eckles@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email 

echo "To: natalie.eckles@mymail.champlain.edu" > emailform.txt
echo "Subject: Failed Logins" >> emailform.txt
echo -e "\n\n" >> emailform.txt
getFailedLogins >> emailform.txt
cat emailform.txt | ssmtp natalie.eckles@mymail.champlain.edu
