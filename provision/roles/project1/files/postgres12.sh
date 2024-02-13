#!/bin/bash
#sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
#sudo apt-get update
#sudo apt-get -y install postgresql-12
#!/bin/bash

sudo apt-get update
sudo apt-get install build-essential zlib1g-dev libreadline-dev libncurses5-dev libssl-dev libgss-dev libldap2-dev libjpeg-dev libpng-dev libxml2-dev libxslt-dev libtcl8.6 libcurl4-gnutls-dev libcunit1-dev libsystemd-dev

wget  https://ftp.postgresql.org/pub/source/v12.17/postgresql-12.17.tar.gz
tar -zxvf postgresql-12.17.tar.gz
cd postgresql-12.17
./configure --prefix=/usr/local/pgsql
make
sudo make install
sudo groupadd postgres
sudo useradd -m -d /usr/local/pgsql -g postgres postgres
sudo mkdir -p /usr/local/pgsql/data
sudo chown -R postgres:postgres /usr/local/pgsql/data
sudo -u postgres /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data

systemd="
[Unit]
Description=PostgreSQL Database Server
Documentation=https://www.postgresql.org/docs/
After=network.target

[Service]
Type=forking
User=postgres
Group=postgres
ExecStart=/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l /usr/local/pgsql/data/logfile start
ExecStop=/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data stop -m fast
ExecReload=/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data reload
PIDFile=/usr/local/pgsql/data/postmaster.pid

[Install]
WantedBy=multi-user.target"

echo "$systemd" | sudo tee /etc/systemd/system/postgresql.service > /dev/null

sudo systemctl daemon-reload
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo systemctl status postgresql
