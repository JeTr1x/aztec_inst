

cd
cd aztec_node
docker compose down --remmove-orphans

cd
cd aztec_agent
docker compose down --remmove-orphans

cd
cd aztec_broker
docker compose down --remmove-orphans

cd
cd prover
docker compose down --remmove-orphans

rm -rf aztec_node aztec_broker aztec_agent
