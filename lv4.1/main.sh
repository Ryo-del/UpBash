#!/bin/bash
if [ -z "$1" ]; then 
    echo "Usage: ./main.sh <service>"
    exit 1
fi

service=$1
touch log.txt
if [ $? -ne 0 ]; then
    echo "Ошибка при создании файла лога."
    exit 1
fi

if systemctl list-unit-files --type=service | grep -q $service; then
    echo "Сервис $service найден."
    exit 1
fi
if systemctl is-active "$service"; then
    echo "Сервис $service активен."
else
    echo "Сервис $service не активен."
    echo "Перезапустить? (y/n): "
    read answer
    if [ "$answer" == "y" ]; then
        sudo systemctl restart "$service"
        if [ $? -eq 0 ]; then
            echo "$service успешно запущен."
            echo "[$(date + '%d/%m/%Y %H:%M:%S')] $service был неактивен и был перезапущен" >> log.txt
            exit 0
        fi
    else 
        exit 0
    fi
fi