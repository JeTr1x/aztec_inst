
PK=$1
PROX=$2
P2P_PORT=$3
API_PORT=$4
ID=$5
TAG=$6 # например 1.2.1  - без V
IP=$(echo "$PROX" | sed -E 's|.*@([^:]+):.*|\1|')


mkdir aztec-sequencer-node-${ID}
cd aztec-sequencer-node-${ID}

wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/sequencer-proxy-compose.yml
sed -i s"|aztecprotocol/aztec:latest|aztecprotocol/aztec:${TAG}|" docker-compose.yml

sudo tee .env > /dev/null <<EOF
ETHEREUM_HOSTS="http://176.9.48.61:18545"
L1_CONSENSUS_HOST_URLS="http://176.9.48.61:13500"
VALIDATOR_PRIVATE_KEY=${PK}
P2P_IP=${IP}
PROXY=${PROX}
P2P_PORT=${P2P_PORT}
API_PORT=${API_PORT}
ID=${ID}
EOF

docker compose up -d
docker compose logs -f
