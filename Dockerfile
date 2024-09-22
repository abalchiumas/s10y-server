FROM steamcmd/steamcmd:latest

RUN apt-get update && apt-get install -y curl lib32gcc-s1 nginx certbot python3-certbot-nginx && rm -rf /var/lib/apt/lists/*

WORKDIR /satisfactory

RUN steamcmd +force_install_dir /satisfactory +login anonymous +app_update 1690800 validate +quit

EXPOSE 7777/udp

EXPOSE 15000/udp

EXPOSE 15777/udp

EXPOSE 80

EXPOSE 443

ENV MAX_PLAYERS=4

COPY start.sh /start.sh

RUN chmod +x /start.sh

COPY nginx.conf.template /etc/nginx/nginx.conf.template

CMD ["/start.sh"]