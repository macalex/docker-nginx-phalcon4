#!/bin/bash

echo "Build a Phalcon project"
echo "PWD:${PWD}"

cp -f ${PWD}/build/env ${PWD}/build/.env
echo ".env is copied"

echo "Run docker-compose"
docker-compose -f ${PWD}/build/docker-compose.yml --project-directory ${PWD}/build up -d --force-recreate --build

echo "Docker containers:"
docker ps

echo "Create phalcon project"
read -p "Docker container name (select from table of 'Docker containers' below): " docker_container_name
read -p "Phalcon type (cli, micro, simple, modules): " phalcon_type
read -p "Phalcon template engine (phtml, volt): " phalcon_template_engine
read -p "Follow the docker-composer log after install is done (Y/n): " docker_compose_log
docker exec -it --user=root ${docker_container_name} phalcon project --directory=/srv/www --type=${phalcon_type} --template-engine=${phalcon_template_engine}
docker exec -it --user=root ${docker_container_name} cp -a /srv/www/default/. /srv/www
docker exec -it --user=root ${docker_container_name} rm -rf /srv/www/default /srv/www/.htaccess /srv/www/public/.htaccess

echo "Show docker-compose log again"
if [[ -z "$docker_compose_log" ]]; then
   follow_docker_compose_log='-f'
else
    if [[ "$docker_compose_log" == 'y' ]]; then
        follow_docker_compose_log='-f'
    else
        follow_docker_compose_log=''
    fi
fi
docker-compose -f ${PWD}/build/docker-compose.yml --project-directory ${PWD}/build logs ${follow_docker_compose_log}

echo "END"