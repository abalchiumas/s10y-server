FROM steamcmd/steamcmd:latest

RUN apt-get update && apt-get install -y \
    curl \
    lib32gcc-s1 \
    nginx \
    certbot \
    python3-certbot-nginx \
    sudo \
 && rm -rf /var/lib/apt/lists/*

RUN groupadd -r satisfactory && useradd -r -g satisfactory -d /home/satisfactory -m satisfactory

WORKDIR /home/satisfactory

RUN chown -R satisfactory:satisfactory /home/satisfactory

USER satisfactory

RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir /home/satisfactory +login anonymous +app_update 1690800 validate +quit

EXPOSE 7777/udp 15000/udp 15777/udp 80 443

ENV MAX_PLAYERS=4

USER root

RUN mkdir -p /var/log/satisfactory && \
    chown -R satisfactory:satisfactory /var/log/satisfactory

RUN echo 'satisfactory ALL=(ALL) NOPASSWD: /usr/sbin/service, /usr/bin/certbot' > /etc/sudoers.d/satisfactory

COPY start.sh /home/satisfactory/start.sh
COPY nginx.conf.template /etc/nginx/nginx.conf.template

RUN chmod +x /home/satisfactory/start.sh && \
    chown satisfactory:satisfactory /home/satisfactory/start.sh

USER satisfactory

CMD ["/home/satisfactory/start.sh"]
