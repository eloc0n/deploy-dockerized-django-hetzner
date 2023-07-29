#!/bin/bash

echo "Acticating environment"
source /opt/virtualenv/bin/activate
exec "$@"
