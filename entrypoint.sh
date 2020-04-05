#!/bin/sh

set -eu

/usr/local/bin/dockerd-entrypoint.sh /bin/drone-ecr
