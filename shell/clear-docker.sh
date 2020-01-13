#!/bin/bash

echo "Down containers"
docker-compose -f ${PWD}/build/docker-compose.yml --project-directory ${PWD}/build down

echo "Remove containers"
docker rm -f $(docker ps -a -q)

echo "Remove images"
docker rmi -f $(docker images -a -q)

echo "Look it!"
docker images
docker ps

echo "END"