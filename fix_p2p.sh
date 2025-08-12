
PROX=$1
ID=$2
IP=$(echo "$PROX" | sed -E 's|.*@([^:]+):.*|\1|')

cd aztec-sequencer-node-${ID}

sed -i -E "s/^(P2P_IP=)[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/\1${IP}/" .env

docker compose down
docker compose up -d
