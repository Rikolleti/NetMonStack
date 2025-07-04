#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
echo 'Installing Docker...'
sudo apt update -y && sudo apt upgrade -y
sudo apt-get install -y docker.io docker-compose

echo 'Installing Python3...'
sudo apt-get install -y python3
sudo apt-get install -y python3-pip

echo 'Installing cron...'
sudo apt-get install -y cron

echo 'Installing unzip...'
sudo apt-get install -y unzip
sudo apt-get install -y jq

echo 'Installing Ansible...'
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ansible/ansible
sudo apt update -y
sudo apt-get install -y ansible

echo 'All done!'
