#!/bin/bash
# sudo yum update - not using because unlike apt-get, yum automatically refreshes the list of packages (right?)
# sudo yum install -y apt-transport-https won't work because doesn't exist for CentOS - try varnish?

## edit apt-key on lines below to rpm something?
#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list

# This won't work because line 3 isn't working...
# deb http://apt.kubernetes.io/ kubernetes-xenial main
# deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable
EOF

# sudo yum update - not using because unlike apt-get, yum automatically refreshes the list of packages (right?)

yum install -y docker-ce=17.03.2~ce-0~ubuntu-xenial # is it OK to use ubuntu in our Docker container? Probably...

systemctl stop docker
modprobe overlay
echo '{"storage-driver": "overlay2"}' > /etc/docker/daemon.json
rm -rf /var/lib/docker/*
systemctl start docker

# Install kubernetes components!
yum install -y \
        kubelet=1.9.2-00 \
        kubeadm=1.9.2-00 \
        kubernetes-cni=0.6.0-00
