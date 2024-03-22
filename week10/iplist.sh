#! /bin/bash

[ $# -ne 1 ] && echo "Usage: iplist.sh <Prefix>" && exit 1

prefix=$1

[ ${#prefix} -lt 5 ]  && printf "Prefix length is too short\nPrefix example: 10.0.17\n" && exit 1

for i in {0..255}
do
        ping -c 1 "$prefix.$i" | grep "64 bytes" | grep -o -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" 
done
