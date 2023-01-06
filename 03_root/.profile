# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

tty -s && mesg n

# juno add #
export CPU_COUNT=$(grep processor /proc/cpuinfo | wc -l)
export CPU_NUM=$(grep processor /proc/cpuinfo | wc -l)

# Alias #
alias setroot='export CROOT=`pwd` && clear'
alias goroot='cd $CROOT'
alias git='LANGUAGE=en_US.UTF-8 /usr/bin/git'
alias foxit='FoxitReader $PWD/$1'
alias tarb='tar --use-compress-program=lbzip2'

#export TAR_OPTIONS="--use-compress-program=lbzip2"

MY_HOME=/home/mm
###   Toolchain   ###
#export CROSS_COMPILE_PATH=/usr/local/arm/arm-eabi-4.6/bin
#export CROSS_COMPILE_PATH=/juno-data2/04_Compiler/arm-eabi-4.6/bin
#export CROSS_COMPILE_PATH=/juno-data2/04_Compiler/arm-eabi-4.8/bin
#export CR2SS_COMPILE=$CROSS_COMPILE_PATH/arm-eabi-

################################################################
###   Java jdk   ###############################################
################################################################
JUNO_JAVA=2
if [ ${JUNO_JAVA} == 1 ]; then
# from 20190113, for lollipop
#export ARCH=arm
echo "<<<<<<<<<<<<<< Java 1.7 >>>>>>>>>>>>"
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
else
# from 20190113, for nougat
#export ARCH=arm64
echo "<<<<<<<<<<<<<< Java 1.8 >>>>>>>>>>>>"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
fi
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

################################################################
###   Anroid sdk   #############################################
################################################################
#export ANDROID_HOME=~/bin/android_sdk
#export PATH=$ANDROID_HOME/platform-tools:$PATH
#export PATH=/root/bin/android/android-sdk/platform-tools:$PATH
#export PATH=/root/00_Ubuntu_setup/04_platform-tools:$PATH

################################################################
###   Android studio   #########################################
################################################################
#export PATH=/root/bin/02_Development_Tools/android-studio/bin:$PATH

###   PATH   ###
export PATH=${MY_HOME}/bin:$PATH
export PATH=${MY_HOME}/00_ubuntu_setup/01_bin:$PATH
export PATH=${MY_HOME}/00_ubuntu_setup/02_scripts:$PATH

### TrueStudio   ###
#export PATH=/opt/Atollic_TrueSTUDIO_for_STM32_x86_64_9.1.0/ide:$PATH

### RockChip Linux download   ###
#export PATH=/home/juno/00_Ubuntu_setup/21_Linux_Upgrade_Tool_v1.21:$PATH

### Default ###
export EDITOR=/usr/bin/vi
export MINICOM='-c on'

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
