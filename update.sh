#!/bin/bash

for ID in $(seq 1 30); do
  cd aztec-sequencer-ipnode-${ID}
  cp data/p2p-private-key p2p-private-key.bak
  docker compose down -v
  rm -rf data
  mkdir data
  cp p2p-private-key.bak data/p2p-private-key
  
  sed -i 's/--network alpha-testnet/--network testnet/' docker-compose.yml && \
  sed -i 's|aztecprotocol/aztec:1.2.1|aztecprotocol/aztec:2.0.2|' docker-compose.yml && \
  docker compose up -d
  cd
  sleep $(( RANDOM % (2200 - 1200 + 1) + 1200 ))
done
