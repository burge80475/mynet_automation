# docker base image for Python3,Netmiko, NAPALM, Pyntc, and Ansible2.8

FROM ubuntu:18.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y --no-install-recommends \
    install telnet curl openssh-client nano vim-tiny iputils-ping python3 build-essential \
    libssl-dev libffi-dev python-pip python3-pip python-setuptools python3-setuptools \
    python-dev net-tools python3 software-properties-common \
    && apt-add-repository -y ppa:ansible/ansible-2.8 \
    && apt-get update && apt-get -y --no-install-recommends install ansible \
    && rm -rf /var/lib/apt/lists/* \
    && easy_install -U pip \
    && pip3 install cryptography netmiko napalm pyntc pyats genie nornir \
    && pip3 install --upgrade paramiko && mkdir /scripts \
    && mkdir /root/.ssh/ \
    && echo "KexAlgorithms diffie-hellman-group1-sha1,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1" > /root/.ssh/config \
    && echo "Ciphers 3des-cbc,blowfish-cbc,aes128-cbc,aes128-ctr,aes256-ctr" >> /root/.ssh/config \
    && chown -R root /root/.ssh/

VOLUME [ "/root","/usr", "/scripts" ]
CMD [ "sh", "-c", "cd; exec bash -i" ]
