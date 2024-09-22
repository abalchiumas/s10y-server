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

ENV PATH="/home/steam:${PATH}"

RUN chmod o+rx /home/steam/steamcmd.sh

RUN ln -s /home/steam/steamcmd.sh /usr/local/bin/steamcmd

USER satisfactory

WORKDIR /home/satisfactory

RUN steamcmd +force_install_dir /home/satisfactory +login anonymous +app_update 1690800 validate +quit

USER root

COPY start.sh /home/satisfactory/start.sh
COPY nginx.conf.template /etc/nginx/nginx.conf.template

RUN chmod +x /home/satisfactory/start.sh && \
    chown satisfactory:satisfactory /home/satisfactory/start.sh

RUN mkdir -p /var/log/satisfactory && \
    chown -R satisfactory:satisfactory /var/log/satisfactory

RUN echo 'satisfactory ALL=(ALL) NOPASSWD: /usr/sbin/service, /usr/bin/certbot' > /etc/sudoers.d/satisfactory

USER satisfactory

CMD ["/home/satisfactory/start.sh"]
