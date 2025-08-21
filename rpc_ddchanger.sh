ID=$1
NEWRPC=$2
NEWCONS=$3


cd aztec-sequencer-ipnode-${ID}
docker compose down
sed -i -E "s|^(ETHEREUM_HOSTS=).*|\1${NEWRPC}|"  .env
sed -i -E "s|^(L1_CONSENSUS_HOST_URLS=).*|\1${NEWCONS}|"  .env

docker compose up -d
