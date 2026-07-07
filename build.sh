#!/usr/bin/env bash
export TAG=$(date '+%s')
docker compose build --push
echo "The tag to use is:  $TAG"
