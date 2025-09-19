#!/bin/bash

NEWRPC=$1
NEWCONS=$2

for ID in $(seq 1 65); do
  echo "Обновляю узел $ID..."

  cd "aztec-sequencer-ipnode-${ID}" || { echo "Нет папки aztec-sequencer-ipnode-${ID}"; exit 1; }

  docker compose down

  sed -i -E "s|^(ETHEREUM_HOSTS=).*|\1${NEWRPC}|" .env
  sed -i -E "s|^(L1_CONSENSUS_HOST_URLS=).*|\1${NEWCONS}|" .env

  docker compose up -d

  cd ..
done
