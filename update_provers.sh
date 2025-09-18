

cd aztec_*
docker compose down -v
rm -rf data*
sed -i 's/--network alpha-testnet/--network testnet/' docker-compose.yml && \
sed -i 's|aztecprotocol/aztec:1.2.1|aztecprotocol/aztec:2.0.2|' docker-compose.yml && \
docker compose up -d
