PK=$1
ID=$2
IP=$3
P2PKEY=$4
RPCIP=$5

cd aztec-sequencer-ipnode-${ID}
docker compose down -v
cd 
rm -rf aztec-sequencer-ipnode-${ID}

mkdir aztec-sequencer-ipnode-${ID}
cd aztec-sequencer-ipnode-${ID}

wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/seq_compose_ip_new.yml

sudo tee .env > /dev/null <<EOF
ETHEREUM_HOSTS="http://${RPCIP}:18545"
L1_CONSENSUS_HOST_URLS="http://${RPCIP}:13500"
VALIDATOR_PRIVATE_KEY=${PK}
DEDICATED_IP=${IP}
ID=${ID}
EOF
mkdir data
sudo tee data/p2p-private-key > /dev/null <<EOF
${P2PKEY}
EOF

docker compose up -d
docker compose logs -f
