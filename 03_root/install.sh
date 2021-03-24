#!/bin/bash

CURRENT_PATH=$(pwd)
USER_HOME=/home/juno

echo ${CURRENT_PATH}

ln -sf ${CURRENT_PATH}/.bashrc ${USER_HOME}/.bashrc
ln -sf ${CURRENT_PATH}/.profile ${USER_HOME}/.profile
ln -sf ${CURRENT_PATH}/.gitconfig ${USER_HOME}/.gitconfig
ln -sf ${CURRENT_PATH}/.vimrc ${USER_HOME}/.vimrc

mkdir -p ${USER_HOME}/.config/terminator/
ln -sf ${CURRENT_PATH}/.config/terminator/config ${USER_HOME}/.config/terminator/config
ln -sf "${CURRENT_PATH}/.config/user-dirs.dirs" "${USER_HOME}/.config/user-dirs.dirs"
