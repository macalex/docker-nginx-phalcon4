FROM nginx

ARG TIMEZONE
RUN echo ${TIMEZONE} > /etc/timezone
RUN ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime