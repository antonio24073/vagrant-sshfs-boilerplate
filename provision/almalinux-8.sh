#!/bin/bash

#ini creating future synced folder
mkdir -p /home/vagrant/project
cd /home/vagrant/project
#end creating future synced folder

# user permission
usermod -a -G wheel vagrant

# ini network
sudo iptables --flush
sudo sed -i 's/#plugins=keyfile,ifcfg-rh/dns=none\n#plugins=keyfile,ifcfg-rh/g' /etc/NetworkManager/NetworkManager.conf
sudo sed -i '{:q;N;s/dns=none\ndns=none/dns=none/g;t q}' /etc/NetworkManager/NetworkManager.conf
sudo systemctl restart NetworkManager.service
sudo bash -c "echo 'nameserver 8.8.8.8' >> /etc/resolv.conf"
sudo bash -c "echo 'nameserver 8.8.4.4' >> /etc/resolv.conf"
sudo systemctl restart NetworkManager.service
# end NetworkManager


# # if you need to change NetworkManager to legacy network uncomment below
# # ini network
# sudo systemctl stop NetworkManager
# sudo systemctl disable NetworkManager
# sudo dnf install network-scripts dhclient -y
# sudo bash -c "echo \"
# [Unit]
# Description=making network connection up
# After=network.target

# [Service]
# ExecStart=bash -c 'dhclient'

# [Install]
# WantedBy=default.target
# RequiredBy=network.target
# \" > /etc/systemd/system/dhclient.service"
# sudo systemctl daemon-reload
# sudo rm /etc/sysconfig/network-scripts/ifcfg-ens*
# sudo touch /etc/sysconfig/network
# sudo systemctl start network
# sudo systemctl enable network
# sudo systemctl enable dhclient
# # end network

# # if your yum update isn't working, uncomment below
# # ini repo
# sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
# sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
# sudo yum remove epel-release --disablerepo=epel -y
# # end repo

#ini updating
sudo yum update -y
sudo yum upgrade yum kernel -y
sudo yum upgrade -y

sudo yum install epel-release -y
sudo yum install dnf -y
sudo yum install dnf-plugins-core -y

sudo dnf update -y
sudo dnf upgrade -y
#end updating

# ini doing swap
sudo dd if=/dev/zero of=/swapfile1 bs=1024 count=$SWAP*1024*1024
sudo chown root:root /swapfile1
sudo chmod 0600 /swapfile1
mkswap /swapfile1
swapon /swapfile1
echo "/swapfile1 none swap sw 0 0" >> /etc/fstab
# end doing swap


