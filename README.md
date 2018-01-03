# Docker Image: Enemy Territory Legacy (etlegacy)

Docker container for ET: Legacy dedicated game server

This will provision an ET: Legacy server with a default RCON password of 'etlegacy'.

## Run

    docker run -p 27960:27960/udp metaxmx/etlegacy

## Stop (All)

    docker stop $(docker ps -a -q)

## Delete

    docker image rm etlegacy -f

## Build

    docker build -t etlegacy .
