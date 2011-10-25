#!/bin/bash

# boilerplate boot script

set -e
PORT=9000
LOGFILE=TODO
NUM_WORKERS=3
USER=TODO

DIR="$( cd "$( dirname "$0" )" && pwd )"

if [[ ! -f $DIR/bin/gunicorn_django ]]; then
    echo "Gunicorn is not installed. pip install gunicorn"
    exit
fi

export PYTHONPATH=".:..:${DIR}/contrib:$PATH"

exec $DIR/bin/gunicorn_django -b 127.0.0.1:$PORT -w $NUM_WORKERS \
    --user=$USER --log-level=debug \
    --log-file=$LOGFILE $DIR/apps/settings.py
