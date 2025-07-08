#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <maxcpu> <maxram> <maxdisk>"
    exit 1
fi

maxcpu=$1
maxram=$2
maxdisk=$3

touch alert.log
if [ $? -ne 0 ]; then
    echo "Failed to create alert.log"
    exit 1
fi

while true; do
    # Получение загрузки CPU
    cpu=$(top -bn1 | grep '%Cpu' | awk '{print $2 + $4}' 2>/dev/null)
    if [ $? -ne 0 ]; then
        echo "Failed to get CPU usage"
        exit 1
    fi

    # Получение загрузки RAM
    ram=$(free | awk '/Mem/{printf "%.1f", ($3/$2)*100}' 2>/dev/null)
    if [ $? -ne 0 ]; then
        echo "Failed to get RAM usage"
        exit 1
    fi

    # Получение загрузки диска
    disk=$(df -h / | awk 'NR==2 {sub(/%/, "", $5); print $5}' 2>/dev/null)
    if [ $? -ne 0 ]; then
        echo "Failed to get disk usage"
        exit 1
    fi

    # Проверка CPU
    if (( $(echo "$cpu >= $maxcpu" | bc -l) )); then 
        echo "[ALERT] CPU usage is $cpu% (threshold $maxcpu%)"
        echo "[$(date +'%d/%m/%Y %H:%M:%S')] CPU: $cpu% | RAM: $ram% | DISK: $disk%" >> alert.log
        if [ $? -ne 0 ]; then
            echo "Failed to write CPU alert to alert.log"
            exit 1
        fi
    fi

    # Проверка RAM
    if (( $(echo "$ram >= $maxram" | bc -l) )); then 
        echo "[ALERT] RAM usage is $ram% (threshold $maxram%)"
        echo "[$(date +'%d/%m/%Y %H:%M:%S')] CPU: $cpu% | RAM: $ram% | DISK: $disk%" >> alert.log
        if [ $? -ne 0 ]; then
            echo "Failed to write RAM alert to alert.log"
            exit 1
        fi
    fi

    # Проверка DISK
    if (( $(echo "$disk >= $maxdisk" | bc -l) )); then 
        echo "[ALERT] DISK usage is $disk% (threshold $maxdisk%)"
        echo "[$(date +'%d/%m/%Y %H:%M:%S')] CPU: $cpu% | RAM: $ram% | DISK: $disk%" >> alert.log
        if [ $? -ne 0 ]; then
            echo "Failed to write DISK alert to alert.log"
            exit 1
        fi
    fi

done
