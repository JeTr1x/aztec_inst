

BROKER_IP=$1

systemctl stop rl-swarm
systemctl disable rl-swarm
mkdir aztec_agent
cd aztec_agent
wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/agentx4-compose.yml
wget -O .env https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/.env.agent
sed -i s"|aztecprotocol/aztec:latest|aztecprotocol/aztec:1.2.1|" docker-compose.yml
sed -ie s"/BROKER_IP=*/BROKER_IP=${BROKER_IP}/" .env
cat .env
docker compose up -d
docker compose logs -f
