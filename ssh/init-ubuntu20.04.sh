#!/bin/bash
set -e

cat>sources.list<<EOF
# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.
deb https://mirrors.cloud.tencent.com/ubuntu/ focal main restricted
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb https://mirrors.cloud.tencent.com/ubuntu/ focal-updates main restricted
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb https://mirrors.cloud.tencent.com/ubuntu/ focal universe
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal universe
deb https://mirrors.cloud.tencent.com/ubuntu/ focal-updates universe
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb https://mirrors.cloud.tencent.com/ubuntu/ focal multiverse
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal multiverse
deb https://mirrors.cloud.tencent.com/ubuntu/ focal-updates multiverse
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal-updates multiverse

## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb https://mirrors.cloud.tencent.com/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal-backports main restricted universe multiverse

## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
# deb http://archive.canonical.com/ubuntu focal partner
# deb-src http://archive.canonical.com/ubuntu focal partner

deb https://mirrors.cloud.tencent.com/ubuntu/ focal-security main restricted
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal-security main restricted
deb https://mirrors.cloud.tencent.com/ubuntu/ focal-security universe
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal-security universe
deb https://mirrors.cloud.tencent.com/ubuntu/ focal-security multiverse
# deb-src https://mirrors.cloud.tencent.com/ubuntu/ focal-security multiverse
EOF

echo "备份sources.list"
cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "替换sources.list"
cp sources.list /etc/apt/sources.list
apt update
export DEBIAN_FRONTEND=noninteractive
apt update && apt upgrade -y && apt autoremove -y
echo "安装curl, sudo, git, python3-dev python3-pip nodejs npm 等常用软件包"
apt install -y curl sudo git python3-dev python3-pip nodejs npm htop apt-utils \
                wget ca-certificates sudo locales vim build-essential openssh-server

echo "配置pip和npm镜像"
pip3 config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
npm config set registry https://mirrors.cloud.tencent.com/npm/

echo "设置时区"
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

echo "设置允许root 密码登录"
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
