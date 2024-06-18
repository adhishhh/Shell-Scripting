#!/bin/bash
n=1
sum=0
until [[ $n -gt 15  || $sum -gt 20 ]]
do
    sum=$(($sum + $n))
    echo "n = $n & sum of first n = $sum"
    ((n++))
done
