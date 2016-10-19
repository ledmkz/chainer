#!/bin/sh
test -f /etc/bootstrapped && exit

apt update
apt install -y git g++ make emacs language-pack-ja-base language-pack-ja gdb python-pip ubuntu-desktop
update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

