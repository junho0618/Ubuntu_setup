#!/bin/bash

for ((i=0;i<65536;i++)); do
#for ((i=0;i<100;i++)); do

num=$(expr ${i} % 3)
echo "$i $num"
echo "GIT$num" > /dev/ttyACM0

sleep 0.5

#echo 'starrt_test' $i > /dev/ttyACM0
#sleep 0.3

done
