FROM nginx:1.21.4

ARG HTPASSWD

RUN apt update && apt install python3-certbot-nginx apache2-utils -y

RUN htpasswd -cb /etc/nginx/.htpasswd admin $HTPASSWD

COPY ./devops/nginx/configuration/ /etc/nginx/