#!/bin/bash

sudo apt update
sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.49.1/prometheus-2.49.1.linux-amd64.tar.gz
tar -xvf prometheus-2.49.1.linux-amd64.tar.gz
cd prometheus-2.49.1.linux-amd64
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/
prometheus --version

if [ $? -eq 0 ]; then
	sudo groupadd --system prometheus
	sudo useradd -s /sbin/nologin --system -g prometheus prometheus
	sudo chown -R prometheus:prometheus /etc/prometheus/ /var/lib/prometheus/
	sudo chmod -R 775 /etc/prometheus/ /var/lib/prometheus/
	prom_service="
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Restart=always
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9091

[Install]
WantedBy=multi-user.target"

#	echo "$prom_service" > /etc/systemd/system/prometheus.service
	echo "$prom_service" | sudo tee /etc/systemd/system/prometheus.service > /dev/null
	sudo systemctl start prometheus
	sudo systemctl enable prometheus
	sudo systemctl status prometheus
	sudo ufw allow 9090
else :
	echo "an error occured /while installing prometheus"

fi
