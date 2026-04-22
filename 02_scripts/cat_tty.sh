#!/bin/sh

stty -F /dev/$1 115200 cs8 -cstopb -parenb -echo
cat /dev/$1
