#!/usr/bin/env bash

# seem to need to run 'airport en0 sniff 11'
# or airport -z

# dis-associate from any AP
airport -z

while true
do
    # 2.4G
    for c in 1 6 11
    do
        echo "channel:" $c
        airport --channel=$c
        sleep 3
    done
    for c in 36 38 40 42 44 46 48 149 151 153 155 157 159 161
    do
        echo "channel:" $c
        airport --channel=$c
        sleep 3
    done
done
