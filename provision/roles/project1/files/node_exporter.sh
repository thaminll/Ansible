#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz

tar xvf node_exporter-1.7.0.linux-amd64.tar.gz

sudo mv node_exporter-1.7.0.linux-amd64/node_exporter /usr/local/bin/

sudo useradd --no-create-home --shell /bin/false node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

node_ex="[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --web.listen-address=":9101"
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target"

echo "$node_ex" | sudo tee /etc/systemd/system/node_exporter.service > /dev/null

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter


