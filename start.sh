#!/bin/bash
set -e

NGINX_LOG=/var/log/satisfactory/nginx.log
CERTBOT_LOG=/var/log/satisfactory/certbot.log
FACTORYSERVER_LOG=/var/log/satisfactory/factoryserver.log

mkdir -p /var/log/satisfactory

envsubst '$SERVER_URL' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

service nginx start > $NGINX_LOG 2>&1

certbot --nginx --non-interactive --agree-tos --email "$EMAIL" -d "$SERVER_URL" >> $CERTBOT_LOG 2>&1

service nginx reload >> $NGINX_LOG 2>&1

./FactoryServer.sh -MaxPlayers=$MAX_PLAYERS >> $FACTORYSERVER_LOG 2>&1
