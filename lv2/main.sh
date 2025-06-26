#!/bin/bash

dir="$1"
if [ -z "$dir" ]; then 
    echo "Usage: $0 <directory>"
    exit 1
fi

a=$(awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -n 5)
echo "$a"
