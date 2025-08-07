

cd
cd aztec_node
docker compose down --remove-orphans

cd
cd aztec_agent
docker compose down --remove-orphans

cd
cd aztec_broker
docker compose down --remove-orphans

cd
cd prover
docker compose down --remove-orphans

cd
rm -rf aztec_node aztec_broker aztec_agent
