#!/bin/sh

set -e

python3 manage.py compilemessages
python3 manage.py collectstatic --noinput
python3 manage.py collectstatic --no-input
python3 manage.py migrate

uwsgi --socket :8000 --master --enable-threads --module tutorial.wsgi