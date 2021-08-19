#!/bin/bash
set -e

lsb_release -a

echo "===== Installing Docker key ====="
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /tmp/docker.key
sudo APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn apt-key add /tmp/docker.key
rm /tmp/docker.key

echo "===== Adding Docker repository ====="
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "===== Updating repositories ====="
sudo apt-get update

echo "===== Installing APT software ====="
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  software-properties-common \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common \
  python3-pip
# Pin at version 1.4.4-1 since there is a known issue in version 1.4.6-1
# LinkL: containerd/containerd#5547
sudo apt-get install containerd.io=1.4.4-1
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  docker-ce docker-ce-cli

echo "===== Installing awscli ====="
sudo pip3 install awscli

echo "===== Setting Docker group permissions ====="
sudo usermod -a -G docker ubuntu

echo "Software installation complete"
