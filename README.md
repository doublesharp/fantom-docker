# fantom-opera-docker
Docker image for Fantom Opera full node

```
docker-compose up --build -d
 
# stop the node
docker-compose down
 
# view the logs
docker-compose logs -f
 
# start a shell in a new container with the same data volume
docker-compose run opera ash
 
# connect to the container
docker exec -it $(docker ps --filter "name=opera" -q) ash
```