# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

tty -s && mesg n

# juno add #
export CPU_COUNT=$(grep processor /proc/cpuinfo | wc -l)

# Alias #
alias setroot='export CROOT=`pwd` && clear'
alias goroot='cd $CROOT'
alias git='LANG=en_US.UTF-8 /usr/bin/git'

###   Toolchain   ###
export ARCH=arm
#export CROSS_COMPILE_PATH=/usr/local/arm/arm-eabi-4.6/bin
#export CROSS_COMPILE_PATH=/juno-data2/04_Compiler/arm-eabi-4.6/bin
#export CROSS_COMPILE_PATH=/juno-data2/04_Compiler/arm-eabi-4.8/bin
#export CROSS_COMPILE=$CROSS_COMPILE_PATH/arm-eabi-

###   Java jdk   ###
#export JAVA_HOME=~/bin/jdk1.6.0
#export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
#export ANDROID_JAVA_HOME=$JAVA_HOME
#export PATH=$JAVA_HOME/bin/:$PATH

###   Anroid sdk   ###
#export ANDROID_HOME=~/bin/android_sdk
#export PATH=$ANDROID_HOME/platform-tools:$PATH
#export PATH=/root/bin/android/android-sdk/platform-tools:$PATH
export PATH=/root/00_Ubuntu-Setup/04_platform-tools:$PATH

###   Android studio   ###
#export PATH=/root/bin/02_Development_Tools/android-studio/bin:$PATH

###   PATH   ###
export PATH=/root/bin:$PATH
export PATH=/root/00_Ubuntu-Setup/01_bin:$PATH
export PATH=/root/00_Ubuntu-Setup/02_scripts:$PATH

### TrueStudio   ###
export PATH=/opt/Atollic_TrueSTUDIO_for_STM32_x86_64_9.1.0/ide:$PATH

### Default ###
export EDITOR=/usr/bin/vi

###   CCache   ###
if [ -d "/usr/lib/ccache" ]; then
    export PATH="/usr/lib/ccache:$PATH"
    export USE_CCACHE=1
    export CCACHE_DIR=~/.ccache
#    export CCACHE_DIR=/.ccache
    ccache -M 100G > /dev/null 2>&1
fi

### .xession-errors
if [ ! -h $HOME/.xsession-errors ]
then
    rm $HOME/.xsession-errors
    ln -s /dev/null $HOME/.xsession-errors
fi

if [ ! -h $HOME/.xsession-errors.old ]
then
    rm $HOME/.xsession-errors.old
    ln -s /dev/null $HOME/.xsession-errors.old
fi

cd
