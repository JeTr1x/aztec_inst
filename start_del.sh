

#!/bin/bash

for id in $(seq 1 20); do
  dir="aztec-sequencer-node-$id"
  
  if [ -d "$dir" ]; then
    echo ">>> Запускаю $dir"
    (
      cd "$dir" || exit
      docker compose up -d
    )
    
    if [ $id -lt 21 ]; then
      delay=$(shuf -i 600-900 -n 1)  # 600-900 секунд = 10-15 минут
      echo ">>> Жду $delay секунд перед запуском следующей ноды..."
      sleep $delay
    fi
  else
    echo "!!! Папка $dir не найдена, пропускаю"
  fi
done
