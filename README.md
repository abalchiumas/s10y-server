# Satisfactory dedicated game server

## Setup

Install Docker/Docker Compose, if not present.

Clone this repository and edit the ```server.env```.

Example of ```server.env```:
```
SERVER_URL=yourdomain.com
EMAIL=youremail@example.com
MAX_PLAYERS=8
MEMORY_LIMIT=16g
MEMORY_RESERVATION=4g
SAVE_LOCATION=/home/user/satisfactory-saves
LOGS_LOCATION=/home/user/satisfactory-logs
```

Notes:
- Make sure the necessary ports (7777/udp, 15000/udp, 15777/udp) are open and accessible for players to connect;
- The email is used for Certbot to automatically obtain and renew SSL certificates from Let’s Encrypt;
- The save files are stored persistently at the location specified in the ```SAVE_LOCATION``` variable;
- The log files are stored persistently at the location specified in the ```LOGS_LOCATION``` variable.

### Opening ports on Linux

First, check if UFW is active:

```sudo ufw status```

If it’s not active, you can enable it with:

```sudo ufw enable```

UDP ports:
- ```sudo ufw allow 7777/udp```
- ```sudo ufw allow 15000/udp```
- ```sudo ufw allow 15777/udp```

TCP ports:
- ```sudo ufw allow 80/tcp```
- ```sudo ufw allow 443/tcp```

Check the status:

```sudo ufw status```

## Starting the server

```docker-compose --env-file server.env up -d```

## Stopping the server

```docker-compose down```

## Getting the container logs

```docker-compose logs -f```