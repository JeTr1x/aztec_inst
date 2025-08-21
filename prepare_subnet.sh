SUBNET=$1
GATEWAY=$2

PARENT=$(ip -o -4 route show to default | awk '{print $5}')

echo "Creating network for $SUBNET with $GATEWAY and $PARENT"

docker network create -d ipvlan \
  --subnet=${SUBNET} \
  --gateway=${GATEWAY} \
  -o parent=${PARENT} \
  -o ipvlan_mode=l3 \
  ipvlan_test

  docker network ls

  sleep 3600
