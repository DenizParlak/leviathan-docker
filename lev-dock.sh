#!/bin/bash

: '

This script creates the Docker environment required for the Leviathan framework to work in Red Hat and CentOS variants.

denizparlak

'

yum -y install docker docker-registry

systemctl start docker
systemctl enable docker

docker pull docker.io/kalilinux/kali-linux-docker

docker -run -i -t docker.io/kalilinux/kali-linux-docker /bin/bash

id="$(docker ps | awk {'print $1'} | grep -v CON*)"

docker exec $id apt-get update &&  python python-pip git gcc make libpcap-dev build-essential checkinstall libssl.0-dev libssh-dev libffi-dev python-dev

docker exec $id git clone https://github.com/leviathan-framework/leviathan.git

docker exec $id cd leviathan

docker exec $id pip install -r requirements.txt

