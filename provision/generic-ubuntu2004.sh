#!/bin/bash

#ini swap
sudo fallocate -l ${SWAP}G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
sudo bash -c "echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab"
#end swap

# ini update
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
# end update

# ini install gnome
sudo apt install slim lightdm vanilla-gnome-desktop vanilla-gnome-default-settings -y
sudo service slim start
# end install gnome
