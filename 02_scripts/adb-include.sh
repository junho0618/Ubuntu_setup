#!/bin/bash
#
# Copyright (C) 2013 Insignal
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

CL_RED="\033[31m"
CL_GRN="\033[32m"
CL_YLW="\033[33m"
CL_BLU="\033[34m"
CL_MAG="\033[35m"
CL_CYN="\033[36m"
CL_RST="\033[0m"

CL_LINE=${CL_BLU}"================================================================================"${CL_RST}

ADB_REPEAT=0

function checkoptions() {
	local ARGS
	local GETOPTS
	local OPTIND
	local OPT
	local OPTARG

	#GETOPTS="a:b:c:d:e:f:g:h:i:j:k:l:m:n:o:p:q:r:s:t:u:v:w:x:y:z:"
	#GETOPTS="abcdefghijklmnopqrstuvwxyz"
	GETOPTS="abcdefghijklmnop:qr:s:tuvwxyz"

	while getopts "$GETOPTS" OPT
	do
		case ${OPT} in
			d)	export ADBOPT="${ADBOPT} -d"
				;;
			e)	export ADBOPT="${ADBOPT} -e"
				;;
			p)	export ANDROID_PRODUCT_OUT="${OPTARG}"
				;;
			s)	export ANDROID_SERIAL="${OPTARG}"
				;;
			r)	export ADB_REPEAT="${OPTARG}"
				;;
			*)	ARGS="${ARGS} -${OPT}"
				;;
		esac
	done
	# save args except used opts
	OPTIND=$(expr $OPTIND - 1)
	[ $OPTIND -gt 0 ] && shift $OPTIND
	OPTS="$ARGS $@"
}

function adb_prefix() {
	echo -e "\
${CL_LINE}
[${CL_YLW}$(date '+%Y-%m-%d %H:%M:%S')${CL_RST}] start
${CL_LINE}
Device: ${CL_CYN}$(adb devices | grep ${ANDROID_SERIAL} | sed -e 's/[ \t].*$//')${CL_RST}
Mode:   ${CL_CYN}$(adb devices | grep ${ANDROID_SERIAL} | sed -e 's/.*[ \t]//')${CL_RST}
${CL_LINE}"
	return 0
}

function adb_postfix() {
	echo -e "\
${CL_LINE}
[${CL_YLW}$(date '+%Y-%m-%d %H:%M:%S')${CL_RST}] finish
${CL_LINE}"
	return 0
}

function adb_waitmsg() {
	local device
	device="${ANDROID_SERIAL}"
	[ -z "$device" ] && device="unknown"
	echo -e "\
${CL_LINE}
[${CL_YLW}$(date '+%Y-%m-%d %H:%M:%S')${CL_RST}] wait for ${device}
${CL_LINE}"
	return 0
}

function adb_device() {
	[ ! -z "${ANDROID_SERIAL}" ] && \
		return 0

	local devices
	local idx
	local cnt
	local sel

	devices=( $(adb devices | sed -e 's/List.*$//' -e 's/[ \t].*//') )
	echo "${devices[@]}"

	idx=0
	cnt=0
	if [ ${#devices[@]} -gt 1 ]; then
		echo "========================================"
		for device in ${devices[@]}
		do
			echo "$cnt: $device"
			cnt=$(expr $cnt + 1)
		done
		read -p "What would you like? (Default:0) " sel
		sel=$(echo ${sel} | sed -e 's/[^0-9]*//g')
		[ ! -z "${sel}" ] && [ ${sel} -le ${cnt} ] && idx=${sel}
	fi
	export ANDROID_SERIAL=${devices[${idx}]}
	echo -e "Target device serial: "${devices[${idx}]}

	return 0
}

function adb_wait() {
	adb_waitmsg
	adb "wait-for-device"

	local devices
	local state

	while :;
	do
		devices=( $(adb devices | sed -e 's/List.*$//' -e 's/[ \t].*//') )
		[ ${#devices[@]} -ge 1 ] && [ -z "${ANDROID_SERIAL}" ] && \
			return 0

		state=$(adb ${ADBOPT} get-serialno)
		[ "${state}" != "unknown" ] && \
			return 0

		sleep 1
	done
}

function adb_main() {
	OPTS=$@
	checkoptions $OPTS
	while :
	do
		adb_wait
		adb_device
		adb_prefix
		adb_handler $OPTS
		[ $? -ne 0 ] && ADB_REPEAT=1
		adb_postfix
		if [ ${ADB_REPEAT} -ne 0 ]; then
			[ ${ADB_REPEAT} -le 1 ] && return 0
			let "ADB_REPEAT = ADB_REPEAT - 1"
		fi
		sleep 1
		echo "

"
	done

	return 0
}

