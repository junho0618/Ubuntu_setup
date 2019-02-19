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

function chroot_step4() {
	echo "run below commands in chroot:"
	echo "mount -t devpts devpts /dev/pts; /bin/bash; umount /dev/pts"
	echo "mount -t devpts devpts /dev/pts; /bin/bash; apt-get clean; umount /dev/pts"
	sudo LC_ALL=C chroot . /bin/bash
	return $?;
}

function chroot_step3() {
	for m in sys dev proc;
	do
		[ ! -d "$m" ] && sudo mkdir -p "$m"
		sudo mount /$m ./$m -o bind;
	done

	chroot_step4
	ret=$?

	for m in sys dev proc;
	do
		sudo umount ./$m;
	done

	return $ret;
}

function chroot_step2() {
	local ret

	[ ! -f etc/resolv.conf.saved ] && \
		sudo mv etc/resolv.conf etc/resolv.conf.saved

	sudo cp /etc/resolv.conf etc/resolv.conf	

	chroot_step3
	ret=$?

	sudo mv etc/resolv.conf.saved etc/resolv.conf

	return $ret
}

function chroot_step1() {
	local ret

	sudo cp /usr/bin/qemu-arm-static usr/bin/
	if [ $? -ne 0 ]; then
		echo "ERROR: cp /usr/bin/qemu-arm-static usr/bin/"
		return 1;
	fi

	chroot_step2
	ret=$?

	sudo rm usr/bin/qemu-arm-static

	return $ret;
}

chroot_step1
