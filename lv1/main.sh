#!/bin/bash

dir="$1"
if [ -z "$dir" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi
if [ ! -d "$dir" ]; then
    echo "Directory does not exist"
    exit 1
fi

echo "Всего файлов: $(find "$dir" -maxdepth 1 -type f | wc -l)"
echo "Всего директорий: $(find "$dir" -maxdepth 1 -type d | wc -l)"
echo "Список файлов (сортировка по размеру) сохранён в report.txt"
touch "report.txt" 
ls -1hS "$dir" > report.txt

