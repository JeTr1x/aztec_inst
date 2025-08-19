ID=$1
NEWRPC=$2
NEWCONS=$3


cd aztec-sequencer-node-${ID}
docker compose down
wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/sequencer-proxy-compose1.2.1.yml
sed -i -E "s|^(ETHEREUM_HOSTS=).*|\1${NEWRPC}|"  .env
sed -i -E "s|^(L1_CONSENSUS_HOST_URLS=).*|\1${NEWCONS}|"  .env

docker compose up -d
