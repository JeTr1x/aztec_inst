
PK=$1
ID=$2
IP=$3


mkdir aztec-sequencer-node-${ID}
cd aztec-sequencer-node-${ID}

wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/sequencer-ip-compose.yml

sudo tee .env > /dev/null <<EOF
ETHEREUM_HOSTS="http://sepolia-rpc-1.rickychez.xyz"
L1_CONSENSUS_HOST_URLS="http://sepolia-consensus-1.rickychez.xyz"
VALIDATOR_PRIVATE_KEY=${PK}
DEDICATED_IP=${IP}
ID=${ID}
EOF

docker compose up -d
docker compose logs -f
