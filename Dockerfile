FROM python:3.8.0-alpine

# copy your local files to your
# docker container except files
# in .dockerignore
COPY . /app

# update your environment to work
# within the folder you copied your 
# files above into
WORKDIR /app

# os requirements to ensure this
# Django project runs with postgresql
# along with a few other deps
RUN apk update \
    && apk --update add \
    bash \ 
    locales \
    libmemcached-dev \ 
    libpq-dev \ 
    libjpeg-dev \
    zlib1g-dev \
    build-essential \
    python3-dev \
    python3-setuptools \
    gcc \
    make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PYTHON_VERSION=3.8
ENV DEBIAN_FRONTEND noninteractive

# Create a Python 3.8 virtual environment in /opt.
# /opt: is the default location for additional software packages.
RUN python3.8 -m venv /opt/virtualenv

# Install requirements to new virtual environment
# requirements.txt must have gunicorn & django
RUN /opt/venv/bin/pip install pip --upgrade && \
    /opt/venv/bin/pip install -r requirements.txt && \
    chmod +x config/entrypoint.sh

# entrypoint.sh to run our gunicorn instance
CMD [ "/app/config/entrypoint.sh" ]