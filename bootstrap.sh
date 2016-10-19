#!/bin/sh
test -f /etc/bootstrapped && exit

apt update
apt install -y git g++ make emacs language-pack-ja-base language-pack-ja gdb python-pip ubuntu-desktop aptitude kpartx parted libyaml-devel
update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

aptitude install -y libpython-dev
pip install -U numpy
pip install chainer

#setup bridge
sed -i -e 's/exit 0//g' /etc/rc.local
echo "ifconfig eth0 down" >> /etc/rc.local
echo "ifconfig eth0 up" >> /etc/rc.local
echo "ip addr flush dev eth0" >> /etc/rc.local
echo "brctl addbr br0" >> /etc/rc.local
echo "brctl stp br0 off" >> /etc/rc.local
echo "brctl setfd br0 0" >> /etc/rc.local
echo "brctl addif br0 eth0" >> /etc/rc.local
echo "brctl stp br0 off" >> /etc/rc.local
echo "ifconfig br0 up" >> /etc/rc.local
echo "dhclient br0 up" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
/etc/rc.local

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

date > /etc/bootstrapped
