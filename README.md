# docker-nginx-phalcon4

It is a skeleton for those who need to use Phalcon 4 with Nginx in an docker environment what was created by docker-compose. 

(From command line these Dockerfiles can be used also individual. Maybe. It hasn't test before. Something sure. The command has to contain the env variables. I think it will work with.)

It contains the docker-compose configs and some bash scripts to help installation and developing.

## Versions
- nginx: 1.17.7 - https://hub.docker.com/_/nginx
- php: 7.2-fpm - https://hub.docker.com/_/php
- Phalcon: 4.0 - https://docs.phalcon.io/4.0/en/introduction
- Phalcon-Devtools: 4.0 - https://docs.phalcon.io/4.0/en/devtools

## Change PHP Version
The PHP version used by the system can be change in the /build/phalcon/Dockerfile. It's defined on the top. If you need higher php version you just have to 

    change the "FROM php:7.2-fpm" line to

    "FROM PHP:7.3-fpm" or
    "FROM PHP:7.4-fpm"

**Note!** The Phalcon 4 is run only with php 7.2 or higher.

## Other package versions
In case of composer, git or zip packages the installed version is always the latest. These were installed by apt.

## Requirements
**It works great under this below environment**
- Docker: 19.03.5 - https://docs.docker.com/install/
- docker-compose: 1.24.1
- MacOS Catalina 10.15.2

## Additional installed packages
- composer
- git
- zip
- unzip

## Project structure
    build
    logs
    shell
    src

**Build:** You find the docker-compose's config and the containers's config's extract which used inside.

**Logs:** Log files are volumed from the containers.

**Shell:** There are some bash scripts here.
- **quick-install.sh:** initialize project. 
- **clear-docker.sh:** clear docker images and containers.

**Src:** The application's source will be in this folder.
- **nginx entry point:** /src/public/<index.php>

## Install
If you want to Install this environment you have two ways.

You can do it with generally known docker commands. See below!

Or if you have little experience in docker then use the /shell/quick-install.sh script to install. This way is great for you when you have no time. This script is initialize docker containers, it install phalcon devtools if needed and it create a phalcon project.

### Quick install
For quick install you have to run the above bash script from project root.
    
    ./shell/quick-install.sh

### Install manual
1. The Dockerfiles use the environment variables which live in /build/.env file. The skeleton contains only a /build/env file. It is a default template file. You have to create a copy what can be used by the Dockerfile.

        cp -f ./build/env ./build/.env

    You must make a statement about 
    - what timezone will be use by the containers (TIMEZONE=Europe/Budapest).
    - you would that phalcon have to be install or not (PHALCON_DEVTOOLS=enabled/disabled or empty).


2. Just it was necessary. The next step is running docker-compose.

        docker-compose -f ./build/docker-compose.yml --project-directory ./build up -d --force-recreate --build

    After when this command is runned success you will have an environment what can be use for running Phalcon 4 php framework.
    You can install phalcon with phalcon-devtools, git or copy from your localhost. 
    The project folder is the /src. 
    The reqest is arrive to /src/public what is /srv/www/public inside the container.

This commands help you install phalcon with palcon devtools:
    
    docker exec -it --user=root <CONTAINER_NAME> phalcon project --directory=/srv/www --type=<PHALCON_TYPE> --template-engine=<PHALCON_TEMPLATE_ENGINE>
    
    docker exec -it --user=root <CONTAINER_NAME> cp -a /srv/www/default/. /srv/www

    docker exec -it --user=root <CONTAINER_NAME> rm -rf /srv/www/default /srv/www/.htaccess /srv/www/public/.htaccess

After then you can use your awesome phalcon project in /src folder.

Other case if you want to clone the project with git you can do it with your own system's git and also the container's git.

    docker exec -it --user=root <CONTAINER_NAME> git ...

And if you have to copy from localhost... No... no... this has to be figured out by you.

## Use phalcon-tools
The phalcon tools can be used if you have install it before. It is installed depends on what is set in the .env environment config file. There is the PHALCON_DEVTOOLS variable what you have to set to 'enabled' if you would liket to use it. 

It has to do before run manually the docker-composer up. Or if you use quick-install.sh the script will ask you about it on time.

You can use phalcon tools command with this command:

    docker exec -it --user=root <CONTAINER_NAME> phalcon <COMMAND> <OPTIONS> --directory=/srv/www

If you have need help run this command:

    docker exec -it --user=root <CONTAINER_NAME> phalcon -h

or visit this page: https://docs.phalcon.io/4.0/en/devtools

## Use composer
You can use the composer too.

First you have to initialize the composer in the project:

    docker exec -it --user=root <CONTAINER_NAME> composer init --working-dir=/srv/www

Use the bellow command in the future:

    docker exec -it --user=root <CONTAINER_NAME> composer <COMMAND> <OPTIONS> --working-dir=/srv/www

You find details about composer's usage here: https://getcomposer.org/doc/

## Working in the containers
If you want to walk in the containers you can use the ordinary command:

    docker exec -it <CONTAINER_NAME> bash

The Phalcon tools, the composer and the other packages was installed in the build_phalcon~ container. If you want to use these, you can do it also with docker exec interactive commands.

## PLEASE NOTE!
- You always have to run the shell scripts from the project root. If you write more scripts in the future follow this pattern!
- When you call composer or phalcon devtools with docker exec, always particular attention to set the working dir. The basic working dir is: /srv/www

