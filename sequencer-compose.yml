name: aztec-sequencer-node
services:
  sequencer-node:
    network_mode: host # Optional, run with host networking
    image: aztecprotocol/aztec:latest
    environment:
      ETHEREUM_HOSTS: $ETHEREUM_HOSTS
      L1_CONSENSUS_HOST_URLS: $L1_CONSENSUS_HOST_URLS
      DATA_DIRECTORY: /data
      VALIDATOR_PRIVATE_KEY: $VALIDATOR_PRIVATE_KEY
      P2P_IP: $P2P_IP
      LOG_LEVEL: debug
    entrypoint: >
      sh -c 'node --no-warnings /usr/src/yarn-project/aztec/dest/bin/index.js start --network alpha-testnet start --node --archiver --sequencer'
    ports:
      - 49400:40400/tcp
      - 49400:40400/udp
      - 8980:8080

    volumes:
      - /root/aztec-sequencer-node/data:/data # Local directory
