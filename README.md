# fantom-docker
Docker image for Fantom Opera full node

create a `.env` file and set:
```
CLOUDFLARE_EMAIL=you@email.com
CLOUDFLARE_API_KEY=cloudflare api key
FANTOM_HOSTNAME=fantom.yourdomain.com
```

use `docker-compose` and `docker` to interact with the containers
```
docker-compose up --build -d
 
# stop the node
docker-compose down
 
# view the logs
docker-compose logs -f
 
# start a shell in a new container with the same data volume
docker-compose run fantom ash

# attach to the go-opera json interface
docker-compose run fantom opera attach
 
# connect to the container
docker exec -it $(docker ps --filter "name=fantom" -q) ash
```