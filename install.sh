#!/bin/bash

UBUNTU_SETUP="/root/00_Ubuntu-Setup"
USER_NAME="juno"
USER_MAIL="junho0618@gitauto.com"

UBUNTU_VERSION=$(lsb_release -a | grep Release| sed -e 's/.*[ \t]//g')
UBUNTU_CODE=$(lsb_release -a | grep Codename | sed -e 's/.*[ \t]//g')

#
# apt get install helper
#
function apt_install() {
	local ret

	for pkg in $@
	do
		cat << EOF
================================================================================
apt-get install $pkg
================================================================================
EOF
		sudo apt-get install -y $@
		ret=$?
		[ $ret -ne 0 ] && \
			echo "ERROR: '$pkg' install failed." && \
			return $ret
		cat << EOF
================================================================================
EOF
	done

	return 0;
}

#
# remove unused package(s)
#

#echo y | sudo apt-get remove nano

#
# git
#

apt_install git
[ $? -ne 0 ] && exit 1
[ -z "$(git config --global --get user.name)" ] && \
	git config –global user.name “${USER_NAME}”
[ -z "$(git config --global --get user.email)" ] && \
	git config –global user.email “${USER_MAIL}”
[ ! -f /root/.gitconfig ] && \
	sudo cp ~/.gitconfig /root/.gitconfig

#
# etckeeper
#

apt_install etckeeper
[ $? -ne 0 ] && exit 1
ETCCONF=/etc/etckeeper/etckeeper.conf
cat ${ETCCONF} | sudo sed \
	-e 's/VCS=/#VCS=/' \
	-e 's/#*VCS=/#VCS=/' \
	-e 's/#VCS="git"/VCS="git"/' > ${ETCCONF}.git
sudo mv ${ETCCONF}.git ${ETCCONF}
if [ ! -d /etc/.git ]; then
	sudo etckeeper init
	sudo etckeeper commit "Initial commit"
fi

#
# network environment
#

STR=$(sysctl net.ipv4.tcp_window_scaling)
if [ "$STR" != "net.ipv4.tcp_window_scaling = 0" ] ; then
	sudo sh -c 'echo "net.ipv4.tcp_window_scaling=0" >> /etc/sysctl.conf'
	sudo sysctl -w net.ipv4.tcp_window_scaling=0 > /dev/null
	sudo etckeeper commit "TCP window scaling"
fi

#
# adds repositories
#

# 12.04 precise
if [ "${UBUNTU_VERSION}" == "12.04" ]; then
# for ubuntu update
sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu '${UBUNTU_CODE}'-updates main restricted universe multiverse'
[ $? -ne 0 ] && exit 1
# for acroread
sudo add-apt-repository "deb http://archive.canonical.com/ ${UBUNTU_CODE} partner"
[ $? -ne 0 ] && exit 1
# manage history
sudo etckeeper commit "add repositories"
fi
# 12.10 quantal
if [ "${UBUNTU_VERSION}" == "12.10" ]; then
# for ubuntu update
sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu '${UBUNTU_CODE}'-updates main restricted'
[ $? -ne 0 ] && exit 1
sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu '${UBUNTU_CODE}'-updates universe'
[ $? -ne 0 ] && exit 1
sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu '${UBUNTU_CODE}'-updates multiverse'
[ $? -ne 0 ] && exit 1
# manage history
sudo etckeeper commit "add repositories"
fi

#
# resynchronize the package index files from their sources
#

# update
sudo apt-get update
[ $? -ne 0 ] && exit 1
# manage history
sudo etckeeper commit "update repositories"

#
# download & install package(s)
#

# utils
apt_install synaptic
[ $? -ne 0 ] && exit 1
apt_install gparted gnome-disk-utility mtp-tools
[ $? -ne 0 ] && exit 1
apt_install hexdiff
[ $? -ne 0 ] && exit 1
apt_install nautilus-open-terminal nautilus-filename-repairer nautilus-compare
[ $? -ne 0 ] && exit 1
apt_install rar unrar p7zip p7zip-rar
[ $? -ne 0 ] && exit 1
apt_install gedit gedit-plugins vim medit bless
[ $? -ne 0 ] && exit 1
apt_install okular
[ $? -ne 0 ] && exit 1
apt_install terminator minicom
[ $? -ne 0 ] && exit 1
apt_install tree
[ $? -ne 0 ] && exit 1
apt_install git git-svn git-gui gitg gitk qgit
[ $? -ne 0 ] && exit 1
apt_install mercurial
[ $? -ne 0 ] && exit 1
# set vim to default editor
sudo update-alternatives --set editor /usr/bin/vim.basic
[ $? -ne 0 ] && exit 1
# font
apt_install \
	fonts-nanum fonts-nanum-coding \
	fonts-nanum-extra fonts-nanum-eco
[ $? -ne 0 ] && exit 1
# services/network
apt_install ssh
[ $? -ne 0 ] && exit 1
apt_install samba system-config-samba
[ $? -ne 0 ] && exit 1
apt_install xinetd tftpd tftp
[ $? -ne 0 ] && exit 1
apt_install nfs-kernel-server
[ $? -ne 0 ] && exit 1
if [ -d ${UBUNTU_SETUP}/postfix ]; then
apt_install postfix mailutils ca-certificates libsasl2-modules mutt
[ $? -ne 0 ] && exit 1
fi
apt_install filezilla
[ $? -ne 0 ] && exit 1
apt_install wireshark
[ $? -ne 0 ] && exit 1
# development
apt_install autoconf
[ $? -ne 0 ] && exit 1
apt_install ccache
[ $? -ne 0 ] && exit 1
apt_install u-boot-tools
[ $? -ne 0 ] && exit 1
apt_install qemu qemu-arm-static
#[ $? -ne 0 ] && exit 1
# compiler
apt_install cpp-4.4 gcc-4.4 gcc-4.4-multilib g++-4.4-multilib
[ $? -ne 0 ] && exit 1
#apt_install cpp-4.5 gcc-4.5 gcc-4.5-multilib g++-4.5-multilib
#[ $? -ne 0 ] && exit 1
apt_install cpp-4.6 gcc-4.6 gcc-4.6-multilib g++-4.6-multilib
[ $? -ne 0 ] && exit 1
apt_install cpp gcc gcc-multilib g++ g++-multilib
[ $? -ne 0 ] && exit 1
# cross compiler
#apt_install cpp-4.4-arm-linux-gnueabi gcc-4.4-arm-linux-gnueabi g++-4.4-arm-linux-gnueabi
#[ $? -ne 0 ] && exit 1
#apt_install cpp-4.5-arm-linux-gnueabi gcc-4.5-arm-linux-gnueabi g++-4.5-arm-linux-gnueabi
#[ $? -ne 0 ] && exit 1
#apt_install cpp-4.6-arm-linux-gnueabi gcc-4.6-arm-linux-gnueabi g++-4.6-arm-linux-gnueabi \
#	gcc-4.6-multilib-arm-linux-gnueabi g++-4.6-multilib-arm-linux-gnueabi
#[ $? -ne 0 ] && exit 1
#apt_install cpp-arm-linux-gnueabi gcc-arm-linux-gnueabi g++-arm-linux-gnueabi
#[ $? -ne 0 ] && exit 1
#apt_install cpp-4.4-arm-linux-gnueabihf gcc-4.4-arm-linux-gnueabihf g++-4.4-arm-linux-gnueabihf
#[ $? -ne 0 ] && exit 1
#apt_install cpp-4.5-arm-linux-gnueabihf gcc-4.5-arm-linux-gnueabihf g++-4.5-arm-linux-gnueabihf
#[ $? -ne 0 ] && exit 1
#apt_install cpp-4.6-arm-linux-gnueabihf gcc-4.6-arm-linux-gnueabihf g++-4.6-arm-linux-gnueabihf \
#	gcc-4.6-multilib-arm-linux-gnueabihf g++-4.6-multilib-arm-linux-gnueabi
#[ $? -ne 0 ] && exit 1
#apt_install cpp-arm-linux-gnueabihf gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
#[ $? -ne 0 ] && exit 1
#apt_install pkg-config-arm-linux-gnueabi pkg-config-arm-linux-gnueabihf
#[ $? -ne 0 ] && exit 1
# extra cross compiler
#if [ -d /storage/bin/toolchain ]; then
#	sudo ln -snf /storage/bin/toolchain /usr/local/arm
#	[ $? -ne 0 ] && exit 1
#fi
# libraries
apt_install zlib1g-dev \
	libsdl1.2debian libsdl1.2-dev \
	libsdl-image1.2 libsdl-image1.2-dev \
	libsdl-mixer1.2 libsdl-mixer1.2-dev \
	libsdl-ttf2.0-0 libsdl-ttf2.0-dev \
	libjpeg-dev libpng12-dev libfreetype6-dev \
	lib32ncurses5-dev lib32ncursesw5-dev
[ $? -ne 0 ] && exit 1
# convert for to565 (for making rle image file)
apt_install imagemagick
[ $? -ne 0 ] && exit 1

#
# android
#

# jdk6
#cd ${UBUNTU_SETUP}
#chmod a+x ./jdk-6u45-linux-x64.bin.sh
#./jdk-6u45-linux-x64.bin.sh
#[ $? -ne 0 ] && \
#	echo "ERROR: jdk-6u45-linux-x64.bin.sh" && \
#	exit 1
apt_install git-core gnupg flex bison gperf build-essential zip \
			curl gcc-multilib g++-multilib libc6-dev-i386 \
			lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev \
			libgl1-mesa-dev libxml2-utils xsltproc unzip libc6-dev \
			libncurses5-dev:i386 libx11-dev:i386 \
			libreadline6-dev:i386 mingw32 tofrodos python-markdown zlib1g-dev:i386

# repo
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# rules for devices
sudo cp -a ${UBUNTU_SETUP}/51-android.rules /etc/udev/rules.d/51-android.rules
[ $? -ne 0 ] && \
	echo "ERROR: sudo cp -a 51-android.rules /etc/udev/rules.d/51-android.rules" && \
	exit 1
sudo perl -pi -e 's/jhlee/$ENV{"USER"}/g' /etc/udev/rules.d/51-android.rules

#
# environment
#

# for using minicom
if [ "${USER}" != "root" ]; then
	sudo adduser ${USER} tty
	sudo adduser ${USER} dialout
fi

# mail forwarding
#if [ -d ${UBUNTU_SETUP}/postfix ]; then
#	sudo cp -a ${UBUNTU_SETUP}/postfix/* /etc/postfix/
#	sudo postmap /etc/postfix/sasl_passwd
#	cat /etc/ssl/certs/Thawte_Premium_Server_CA.pem | sudo tee -a /etc/postfix/cacert.pem
#	sudo /etc/init.d/postfix reload
#fi

#
# extra package
#

#
#[ ! -d ~/bin ] && mkdir ~/bin
#if [ -d cp ${UBUNTU_SETUP}/bin ]; then
#	cp ${UBUNTU_SETUP}/bin/* ~/bin/
#fi
#if [ -d cp ${UBUNTU_SETUP}/scripts ]; then
#	cp ${UBUNTU_SETUP}/scripts/* ~/bin/
#fi

#
#mv ~/.bashrc ~/.bashrc.orig
#cat ${UBUNTU_SETUP}/envsetup >> ~/.bashrc

# download - virtualbox, chrome, acroread
#firefox \
#	http://www.virtualbox.org/wiki/Linux_Downloads \
#	http://www.google.com/chrome/eula.html?hl=ko \
#	http://get.adobe.com/kr/reader/otherversions/ \
#	http://www.scootersoftware.com/download.php

# crontab
#crontab -e
