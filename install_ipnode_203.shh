PK=$1
ADDR=$2
ZTADDR=$3
DEDICIP=$4
ID=$5


echo "Обновляю узел $ID..."
cd "aztec-sequencer-ipnode-${ID}" || { echo "Нет папки aztec-sequencer-ipnode-${ID}"; exit 1; }

cp data/p2p-private-key p2p-private-key.baks
docker compose down -v
rm -rf data
mkdir data
mkdir keys
mv p2p-private-key.baks data/p2p-private-key
wget -O .env https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/.env203new
wget -O docker-compose.yml https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/dockerip_new203.yml
wget -O keystore.json https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/keystore.json

mv keystore.json keys/keystore.json

sed -i 's/^P2P_IP=.*/P2P_IP='${DEDICIP}'/' .env


sed -i 's/ETH_PRIVATE_KEY_0/'${PK}'/' keys/keystore.json
sed -i 's/ETH_PRIVATE_KEY_1/'${PK}'/' keys/keystore.json
sed -i 's/ETH_ADDRESS_2/'${ADDR}'/' keys/keystore.json
sed -i 's/AZTEC_ADDRESS_0/'${ZTADDR}'/' keys/keystore.json



docker compose up -d
docker  compose logs -f
