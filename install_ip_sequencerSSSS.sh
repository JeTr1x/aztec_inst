
PK=$1
ID=$2
IP=$3
RPCIP=$4

cd aztec-sequencer-ipnode-${ID}
docker compose down
cd 
rm -rf aztec-sequencer-ipnode-${ID}

mkdir aztec-sequencer-ipnode-${ID}
cd aztec-sequencer-ipnode-${ID}

wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/sequencerss-ip-compose.yml

sudo tee .env > /dev/null <<EOF
ETHEREUM_HOSTS="http://${RPCIP}:18545"
L1_CONSENSUS_HOST_URLS="http://${RPCIP}:13500"
VALIDATOR_PRIVATE_KEY=${PK}
DEDICATED_IP=${IP}
ID=${ID}
EOF
cp -r ~/aztecsnap/data data

docker compose up -d
docker compose logs -f
