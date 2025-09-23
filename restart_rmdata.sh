#!/bin/bash

for ID in $(seq 1 65); do
  echo "Обновляю узел $ID..."

  cd "aztec-sequencer-ipnode-${ID}" || { echo "Нет папки aztec-sequencer-ipnode-${ID}"; exit 1; }
  cp data/p2p-private-key p2p-private-key.baks
  docker compose down -v
  rm -rf data
  mkdir data
  mv p2p-private-key.baks data/p2p-private-key
  sed -i 's/aztec:2.0.2/aztec:2.0.3/' docker-compose.yml

  docker compose up -d

  cd ..
done
