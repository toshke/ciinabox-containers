#!/bin/bash

set -e
set -x

aws s3 cp s3://$SOURCE_BUCKET/loadtesting/locustfile.py /src/locustfile.py

CLI_OPTS=""
if [ "$LOCUST_MODE" == "master" ]; then
  CLI_OPTS="${CLI_OPTS} --port=8080"
fi

if [ "$LOCUST_MODE" == "slave" ]; then
  CLI_OPTS="${CLI_OPTS} --master-host=${MASTER_HOST}"
fi

CLI_OPTS="$CLI_OPTS -f /src/locustfile --${LOCUST_MODE} --host=${LOCUST_HOST}"

locust -f /src/locustfile $CLI_OPTS
