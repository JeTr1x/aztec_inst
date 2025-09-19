ID=$1


cd aztec-sequencer-ipnode-${ID}
docker compose down -v
cd 
rm -rf aztec-sequencer-ipnode-${ID}
