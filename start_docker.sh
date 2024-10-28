#!/bin/bash

# ボリュームが存在しない場合は作成
if ! docker volume ls -q | grep -q "^https-nginx-certs$"; then
    docker volume create https-nginx-certs
fi

docker compose up --build --force-recreate --remove-orphans
