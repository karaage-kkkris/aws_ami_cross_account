#!/bin/bash

set +e

echo "===== Initial Update ====="
sudo apt-get update

echo "===== Installing packages ====="
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
  software-properties-common \
  build-essential

docker --help >/dev/null 2>&1
if [ $? != 0 ]; then
  echo "===== Adding Docker Repository ====="
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-cache policy docker-ce

  echo "===== Installing Docker ====="
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce;
else
  echo "Docker already installed, skipping."
fi

# Bestow docker permissions to user, required for "make test" to work
sudo usermod -a -G docker ubuntu

# Downgrade due to known issue in 1.4.6-1
ver=$(dpkg -l | grep containerd.io | awk '{print $3}')
if [ "$ver" = "1.4.6-1" ]; then
  echo "***** Detected defective containerd.io version. Downgrading."
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-downgrades containerd.io=1.4.4-1
fi
