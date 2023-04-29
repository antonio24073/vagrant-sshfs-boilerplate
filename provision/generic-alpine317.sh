#!/bin/bash

# ini install docker
sudo apk add --update docker docker-compose shadow openrc
sudo rc-update add docker boot
sudo service docker start
sudo addgroup vagrant docker
sudo usermod -aG docker vagrant
mkdir /home/vagrant/captain
# end install docker