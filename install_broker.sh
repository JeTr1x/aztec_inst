
mkdir aztec_broker
cd aztec_broker
wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/broker-compose.yml
wget -O .env https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/.env.broker
sed -i s"|aztecprotocol/aztec:latest|aztecprotocol/aztec:1.2.1|" docker-compose.yml
IP=$(curl 2ip.ru)
sed -ie s"/P2P_IP=/P2P_IP=${IP}/" .env
cat .env
docker compose up -d
docker compose logs -f
