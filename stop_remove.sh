ID=$1


cd aztec-sequencer-node-${ID}
docker compose down
cd 
rm -rf aztec-sequencer-node-${ID}
