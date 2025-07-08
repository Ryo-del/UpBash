#!/bin/bash
maxcpu=$1
maxram=$2
maxdisk=$3

while ["$maxcpu" -ge "$cpu" ] 
do
    cpu=$(top -bn1 | awk '/Cpu/ { print $2}')
    ram=$(free -m | awk '/Mem/ { print ($3/$2)*100 }')
    disk=$(df -h | awk 'NR==2 { print $5 }' | tr -d '%')
done