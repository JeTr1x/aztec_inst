
PK=$1
ADDR=$2
ZTADDR=$3



mkdir -p aztec-sequencer/keys aztec-sequencer/data
cd aztec-sequencer
wget -O .env https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/.env203new
wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/docker-composenew2.0.3.yml
wget -O keystore.json https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/keystore.json

mv keystore.json keys/keystore.json

P2P_IP=$(curl 2ip.ru)
sed -i 's/^P2P_IP=.*/P2P_IP='${P2P_IP}'/' .env


sed -i 's/ETH_PRIVATE_KEY_0/'${PK}'/' keys/keystore.json
sed -i 's/ETH_PRIVATE_KEY_1/'${PK}'/' keys/keystore.json
sed -i 's/ETH_ADDRESS_2/'${ADDR}'/' keys/keystore.json
sed -i 's/AZTEC_ADDRESS_0/'${ZTADDR}'/' keys/keystore.json



docker compose up -d
docker  compose logs -f

