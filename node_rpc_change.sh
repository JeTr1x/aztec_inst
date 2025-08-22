NEWRPC=$1
NEWCONS=$2

cd aztec_node

sed -i -E "s|^(ETHEREUM_HOSTS=).*|\1${NEWRPC}|"  .env
sed -i -E "s|^(L1_CONSENSUS_HOST_URLS=).*|\1${NEWCONS}|"  .env

docker compose down
docker compose up -d
