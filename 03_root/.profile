# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#tty -s && mesg n

# Alias #
alias setroot='export CROOT=`pwd` && clear'
alias goroot='cd $CROOT'
#alias git='LANGUAGE=en_US.UTF-8 /usr/bin/git'
alias foxit='FoxitReader $PWD/$1'
alias tarb='tar --use-compress-program=lbzip2'
#alias terminator='terminator --new-instance --no-dbus'

MY_HOME=/home/jhlee

###   PATH   ###
export PATH=${MY_HOME}/bin:$PATH
export PATH=${MY_HOME}/00_ubuntu_setup/01_bin:$PATH
export PATH=${MY_HOME}/00_ubuntu_setup/02_scripts:$PATH

### for remote adb
export ADB_SERVER_SOCKET=tcp:$(echo $SSH_CLIENT | awk '{print $1}'):5037

### for Qualcomm eSDK
export ESDK_ROOT=/home/jhlee/01_work/10_Solutions/03_QIM_eSDK/qcom-wayland_sdk

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

### for Qualcomm V4l2-video-test-app
#export ARCH=arm64
#export PATH="$PATH:/usr/aarch64-linux-gnu/bin"
#export PATH="$PATH:/pkg/asw/compilers/gnu/linaro-toolchain/5.1/bin/"
#export CROSS_COMPILE=/local/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-


### for IX3000 Compile
export PATH=/opt/arm-sav837/bin:$PATH
