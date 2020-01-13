FROM php:7.2-fpm

ARG PSR_VERSION=0.7.0
ARG PHALCON_VERSION=4.0.0
ARG PHALCON_EXT_PATH=php7/64bits
ARG PHALCON_DEVTOOLS
ARG TIMEZONE

RUN echo ${TIMEZONE} > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

RUN set -xe && \
        curl -LO https://github.com/jbboehr/php-psr/archive/v${PSR_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PSR_VERSION}.tar.gz && \
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PHALCON_VERSION}.tar.gz && \
        docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/cphalcon-${PHALCON_VERSION}/build/${PHALCON_EXT_PATH} \
        && \
        rm -r \
            ${PWD}/v${PSR_VERSION}.tar.gz \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/v${PHALCON_VERSION}.tar.gz \
            ${PWD}/cphalcon-${PHALCON_VERSION} \
        && \
        curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
        && \
        php -m

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -yq \
        git \
        zip \
        unzip

RUN if [ "${PHALCON_DEVTOOLS}" = "enabled" ] ; \ 
    then \
        mkdir -p /home/phalcon-tools && cd /home/phalcon-tools && \
        composer require phalcon/devtools:4.0 && \
        ln -sf /home/phalcon-tools/vendor/phalcon/devtools/phalcon /usr/bin/phalcon && \
        chmod ugo+x /usr/bin/phalcon \
    ; fi