
PK=$1
PROX=$2
P2P_PORT=$3
API_PORT=$4
TAG=$5 # например 1.2.1  - без V
IP=$(curl 2ip.ru)

mkdir aztec-sequencer-node
cd aztec-sequencer-node

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
EOF

docker compose up -d
docker compose logs -f
