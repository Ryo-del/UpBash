#!/bin/bash

read -p "Enter the directory name: " dir 

echo "Всего файлов: $(find "$dir" -maxdepth 1 -type f | wc -l)"
echo "Всего директорий: $(find "$dir" -maxdepth 1 -type d | wc -l)"
echo "Список файлов (сортировка по размеру) сохранён в report.txt"
touch "report.txt" 
echo $(ls -S "$dir") > report.txt
