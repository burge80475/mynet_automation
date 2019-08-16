# docker base image for Python3,Netmiko, NAPALM, Pyntc, and Ansible2.8

FROM	ubuntu:18.04

ARG		DEBIAN_FRONTEND=noninteractive 
RUN		apt-get update && apt-get -yq --no-install-recommends \
		install apt-utils telnet curl openssh-client nano vim-tiny iputils-ping python3.6 build-essential cloud-init \
		libxml2-dev libxslt1-dev libssl-dev libffi-dev python3-pip python3-setuptools python3-dev net-tools software-properties-common \
		&& apt-add-repository -y ppa:ansible/ansible-2.8 \
		&& apt-get update && apt-get -y --no-install-recommends install ansible \
		&& rm -rf /var/lib/apt/lists/* \
		&& python3 -m pip install --upgrade pip setuptools wheel \
		&& rm -rf /usr/lib/python3/dist-packages/PyYAML\
		&& rm -rf /usr/lib/python3/dist-packages/PyYAML-* \
		&& pip3 install "PyYAML==5.1.2" \
		&& pip3 install "cryptography==2.5" \
		&& pip3 install ncclient netmiko napalm pyntc \
		&& pip3 install --upgrade paramiko && mkdir /scripts \
		&& mkdir -p /root/.ssh \
		&& echo "KexAlgorithms diffie-hellman-group1-sha1,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1" > /root/.ssh/config \
		&& echo "Ciphers 3des-cbc,blowfish-cbc,aes128-cbc,aes128-ctr,aes256-ctr" >> /root/.ssh/config \
		&& chown -R root:root /root/.ssh/

VOLUME 	[ "/root","/usr", "/scripts" ]
CMD 	[ "sh", "-c", "cd; exec bash -i" ] 
