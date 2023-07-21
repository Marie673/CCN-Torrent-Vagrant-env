#!bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean

sudo apt-get install -y build-essential
sudo apt-get install -y libssl-dev
sudo apt-get install -y git
sudo apt-get install -y expect
sudo apt-get install -y python3-pip
sudo apt-get install -y cmake
pip3 install setuptools click numpy
