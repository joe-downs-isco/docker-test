#!/bin/bash
set -euox pipefail

docker run --detach --name Pipeline\
       --mount type=bind,source=/home/joe/git-work/pipeline,target=/var/www/html \
       -p 80:80 \
       foo:bar
