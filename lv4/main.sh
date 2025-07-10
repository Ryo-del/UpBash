#!/bin/bash

# Проверка наличия аргумента
if [ -z "$1" ]; then
    echo "Usage: $0 <process_name>"
    exit 1
fi

process="$1"
touch proc_alert.log
if [ $? -ne 0 ]; then
    echo "Failed to create alert.log"
    exit 1
fi

# Проверка запущен ли процесс
if pgrep -x "$process" > /dev/null 2>&1; then
    # Если процесс запущен, выводим его PID
    pids=$(pgrep -x "$process")
    echo "$process is already running (PID: $pids)"
else
    echo "$process is not running"
    echo "[$(date +'%d/%m/%Y %H:%M:%S')] $process is not running" >> proc_alert.log
fi
