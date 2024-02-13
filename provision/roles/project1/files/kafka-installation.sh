#!/bin/bash

wget https://downloads.apache.org/kafka/3.6.1/kafka_2.13-3.6.1.tgz
tar -xzf kafka_2.13-3.6.1.tgz

sudo mv kafka_2.13-3.6.1 /opt/kafka/

kafka_config="[Unit]
Description=Apache Kafka Server
Documentation=http://kafka.apache.org/documentation.html
After=network.target remote-fs.target

[Service]
Type=simple
User=root
ExecStart=/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
ExecStop=/opt/kafka/bin/kafka-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target"

echo "$kafka_config" | sudo tee /etc/systemd/system/kafka.service > /dev/null

sudo systemctl daemon-reload
sudo systemctl enable kafka
sudo systemctl start kafka

sudo systemctl status kafka

/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties &

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties &

/opt/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic mytopic

/opt/kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092
