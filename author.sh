#!/bin/bash
# Author : Shivendra Pratap

read -p "Enter author name: " input

clean_name=""

for (( i=0; i<${#input}; i++ ))
do
    ch="${input:i:1}"

    if [[ "$ch" =~ [a-zA-Z\ ] ]]; then
        clean_name+="$ch"
    fi
done

# default name if nothing valid remains
clean_name=${clean_name:-"Shivendra Pratap"}

echo "Author of this repo is $clean_name"
