#!/bin/bash
CD /home/ansible/scripts
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.12.1-amd64.deb
sudo dpkg -i elasticsearch-8.12.0-amd64.deb
sudo service elasticsearch start
sudo systemctl enable elasticsearch
