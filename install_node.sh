

PK=$1
ADDRESS=$2
BROKER_IP=$3
SERVER_IP=$4


systemctl stop rl-swarm
systemctl disable rl-swarm
mkdir aztec_node
cd aztec_node
wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/node-compose.yml
wget -O .env https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/.env.node
sed -ie s"/P2P_IP=/P2P_IP=${SERVER_IP}/" .env
sed -ie s"/BROKER_IP=/BROKER_IP=${BROKER_IP}/" .env
sed -ie s"/PROVER_PUBLISHER_PRIVATE_KEY=/PROVER_PUBLISHER_PRIVATE_KEY=${PK}/" .env
sed -ie s"/PROVER_ID=/PROVER_ID=${ADDRESS}/" .env
sleep 10
docker compose up -d
docker compose logs -f
                            
