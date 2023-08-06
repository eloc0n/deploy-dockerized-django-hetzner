FROM python:3.8.0-alpine

# copy your local files to your
# docker container except files
# in .dockerignore
COPY . /app

# update your environment to work
# within the folder you copied your 
# files above into
WORKDIR /app

ARG UID
ARG GID

RUN addgroup -S django -g $GID \
    && adduser -S django -u $UID -g $GID

# os requirements to ensure this
# Django project runs with postgresql
# along with a few other deps
RUN apk update \
    && apk --update add bash jq curl ca-certificates \
    py-openssl py3-psycopg2 postgresql-dev jpeg-dev \
    musl-dev libffi-dev libressl-dev build-base \
    make gcc g++ libxml2-dev libxslt-dev gettext git \
    openssh-client  \
    && rm -rf /var/cache/apk

ENV PYTHON_VERSION=3.8
ENV DEBIAN_FRONTEND noninteractive

# Permissions
COPY --chown=django:django . /app
COPY --chown=django:django devops/django/runserver.sh /
COPY --chown=django:django devops/django/entrypoint.sh /
RUN chown django:django /app/devops/django/runserver.sh

# Static files
RUN mkdir -p /app/staticfiles
RUN chown django:django /app/staticfiles

# Logs
RUN mkdir -p /logs
RUN chown django:django /logs

# Create a Python 3.8 virtual environment in /opt.
# /opt: is the default location for additional software packages.
RUN python3.8 -m venv /opt/virtualenv

# Install requirements to new virtual environment
# requirements.txt must have gunicorn & django
RUN /opt/virtualenv/bin/pip install pip --upgrade && \
    /opt/virtualenv/bin/pip install -r requirements.txt

USER django

# entrypoint.sh to activate environment
ENTRYPOINT ["/entrypoint.sh" ]