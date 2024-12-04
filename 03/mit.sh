#!/bin/bash

filename=$1

if [ $# -lt 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi


if [ -f "$filename" ]; then
    echo "File exists"
else
    echo "File does not exist"
    exit 1
fi

sum=0
mul=1

while read -r line; do
    if [[ "$line" == "do()" ]]; then
        mul=1
        continue
    fi
    if [[ "$line" == "don't()" ]]; then
        mul=0
        continue
    fi
    if [[ "$mul" -eq 0 ]]; then
        continue
    fi
    temp=($(echo "$line" | awk -F "[(,)]" '{print $2,$3}'))
    num1=${temp[0]}
    num2=${temp[1]}
    mul=$((num1*num2))
    sum=$((sum+mul))
done < <(grep -Po "mul\([1-9][0-9]{0,2},[1-9][0-9]{0,2}\)|do\(\)|don't\(\)" "$filename")

echo "Sum: $sum"



