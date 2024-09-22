#!/bin/bash
set -e

NGINX_LOG=/var/log/satisfactory/nginx.log
CERTBOT_LOG=/var/log/satisfactory/certbot.log
FACTORYSERVER_LOG=/var/log/satisfactory/factoryserver.log

mkdir -p /var/log/satisfactory

sudo envsubst '$SERVER_URL' < /etc/nginx/nginx.conf.template | sudo tee /etc/nginx/nginx.conf > /dev/null

sudo service nginx start 2>&1 | tee -a $NGINX_LOG

sudo certbot --nginx --non-interactive --agree-tos --email "$EMAIL" -d "$SERVER_URL" 2>&1 | tee -a $CERTBOT_LOG

sudo service nginx reload 2>&1 | tee -a $NGINX_LOG

cd /home/satisfactory
./FactoryServer.sh -MaxPlayers=$MAX_PLAYERS 2>&1 | tee -a $FACTORYSERVER_LOG
