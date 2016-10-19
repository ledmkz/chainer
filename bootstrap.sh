#!/bin/sh
test -f /etc/bootstrapped && exit

apt update
apt install -y git g++ make emacs language-pack-ja-base language-pack-ja gdb python-pip ubuntu-desktop aptitude
update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

aptitude install -y libpython-dev
pip install -U numpy
pip install chainer

# install pyenv
cd /usr/local
git clone git://github.com/yyuu/pyenv.git ./pyenv
mkdir -p ./pyenv/versions ./pyenv/shims
cd pyenv/plugins/
git clone git://github.com/yyuu/pyenv-virtualenv.git
echo 'export PYENV_ROOT="/usr/local/pyenv"' | tee -a /etc/profile.d/pyenv.sh
echo 'export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"' | tee -a /etc/profile.d/pyenv.sh
source /etc/profile.d/pyenv.sh
# sudo visudo
pyenv install -v 3.5.2
pyenv global 3.5.2

