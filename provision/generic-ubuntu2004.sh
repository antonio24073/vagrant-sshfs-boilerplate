#!/bin/bash

# ini update
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
# end update

#ini swap
sudo fallocate -l ${SWAP}G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
sudo bash -c "echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab"
#end swap

# ini install gnome
sudo DEBIAN_FRONTEND=noninteractive apt-get install ubuntu-gnome-desktop ubuntu-gnome-default-settings -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install lightdm -y
sudo bash -c "echo '/usr/sbin/lightdm' > /etc/X11/default-display-manager"
sudo bash -c "echo 'set shared/default-x-display-manager lightdm' | debconf-communicate"
sudo systemctl start lightdm
# end install gnome

