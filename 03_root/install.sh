#!/bin/bash

CURRENT_PATH=$(pwd)

echo ${CURRENT_PATH}

ln -sf ${CURRENT_PATH}/.bashrc /root/.bashrc
ln -sf ${CURRENT_PATH}/.profile /root/.profile
ln -sf ${CURRENT_PATH}/.gitconfig /root/.gitconfig
ln -sf ${CURRENT_PATH}/.vimrc /root/.vimrc

ln -sf ${CURRENT_PATH}/.config/terminator/config /root/.config/terminator/config
