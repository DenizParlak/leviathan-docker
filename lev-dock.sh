#!/bin/bash

: '

This script creates the Docker environment required for the Leviathan framework to work in Red Hat and CentOS variants.

deniz

'

PS3='Select your distro: '
options=("Debian/Ubuntu" "Kali" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Debian/Ubuntu")
        
        yum -y install docker docker-registry

 systemctl start docker
 systemctl enable docker   
 
 docker pull docker.io/ubuntu
 
 docker run -i -t -d docker.io/ubuntu /bin/bash
 
        id="$(docker ps | awk {'print $1'} | grep -v CON*)"

docker exec $id bash -c 'apt-get update ; apt-get install -y python python-pip git gcc make libpcap-dev build-essential checkinstall libssh-dev libffi-dev python-dev'

docker exec $id bash -c 'git clone https://github.com/leviathan-framework/leviathan.git'

docker exec $id bash -c 'cd leviathan'

docker exec $id bash -c 'pip install -r requirements.txt'
            ;;
        "Kali")
yum -y install docker docker-registry

systemctl start docker
systemctl enable docker     

docker pull docker.io/kalilinux/kali-linux-docker

docker run -i -t -d docker.io/kalilinux/kali-linux-docker /bin/bash

id="$(docker ps | awk {'print $1'} | grep -v CON*)"

docker exec $id bash -c 'apt-get update ; apt-get install -y python python-pip git gcc make libpcap-dev build-essential checkinstall libssh-dev libffi-dev python-dev'

docker exec $id bash -c 'git clone https://github.com/leviathan-framework/leviathan.git'

docker exec $id bash -c 'cd leviathan'

docker exec $id bash -c 'pip install -r requirements.txt'
;;
        "Let me go!")
            bye.
            ;;
        *) echo "wtf?";;
    esac
done

