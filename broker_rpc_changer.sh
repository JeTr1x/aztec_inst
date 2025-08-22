NEWRPC=$1


cd aztec_broker

sed -i -E "s|^(ETHEREUM_HOSTS=).*|\1${NEWRPC}|"  .env

docker compose down
docker compose up -d
