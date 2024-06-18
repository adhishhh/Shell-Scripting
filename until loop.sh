#!/bin/bash
count=1

# this is an infinite loop
until false
do
    
    if [[ $count -eq 25 ]]
    then
    
        ##   terminates the loop.
        break
    elif [[ $count%5 -eq 0 ]]
    then
    
        ## terminates the current iteration.
        continue
    fi
    echo "$count"
    ((count++))
done
