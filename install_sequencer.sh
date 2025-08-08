
PK=$1
IP=$(curl 2ip.ru)

mkdir aztec-sequencer-node
cd aztec-sequencer-node

wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/sequencer-compose.yml


sudo tee .env > /dev/null <<EOF
ETHEREUM_HOSTS="http://176.9.48.61:18545"
L1_CONSENSUS_HOST_URLS="http://176.9.48.61:13500"
VALIDATOR_PRIVATE_KEY=${PK}
P2P_IP=${IP}
EOF

docker compose up -d
docker compose logs -f
