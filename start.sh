#!/bin/bash

envsubst '$SERVER_URL' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

service nginx start

certbot --nginx --non-interactive --agree-tos --email "$EMAIL" -d "$SERVER_URL"

service nginx reload

./FactoryServer.sh -MaxPlayers=$MAX_PLAYERS
