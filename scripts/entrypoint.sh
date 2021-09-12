#!/bin/sh

set -e

DJANGO_PORT=8000

python3 manage.py compilemessages
python3 manage.py collectstatic --noinput
python3 manage.py collectstatic --no-input
python3 manage.py migrate

uwsgi --socket :$DJANGO_PORT --master --enable-threads --module djangoproject.wsgi