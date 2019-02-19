#!/bin/bash

count=0

for count in {1..100}
do
#	echo "Test $count times"
	ret=$(adb devices | grep device | awk '{print $1}')
	if [ -n "$ret" ]; then
#		echo "$ret"
		adb logcat -d >> $count.txt
		sleep 180
		adb reboot
	else
		echo "not found"
	fi
	sleep 1
done
