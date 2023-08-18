FROM nginx:1.21.4

ARG HTPASSWD

RUN apt update && add certbot-nginx && apt install apache2-utils -y

RUN htpasswd -cb /etc/nginx/.htpasswd admin $HTPASSWD

COPY ./devops/nginx/configuration/ /etc/nginx/