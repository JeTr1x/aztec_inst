#!/bin/bash
# === Настройки ===
BLOCK_NETS=(
    "10.0.0.0/8"
    "172.16.0.0/12"
    "192.168.0.0/16"
    "100.64.0.0/10"
    "198.18.0.0/15"
    "169.254.0.0/16"
    "100.79.0.0/16"
    "100.113.0.0/16"
    "172.0.0.0/8"
)

# === Определяем режим iptables ===
if iptables --version 2>/dev/null | grep -q "nf_tables"; then
    IPT="iptables"
    NFT_ACTIVE=true
else
    IPT="iptables"
    NFT_ACTIVE=false
fi

echo "[INFO] Используем $IPT, nftables активен: $NFT_ACTIVE"

# === Чистим старые правила ===
for NET in "${BLOCK_NETS[@]}"; do
    $IPT -D OUTPUT -d "$NET" -j DROP 2>/dev/null
    $IPT -D FORWARD -d "$NET" -j DROP 2>/dev/null
done

# === Добавляем новые ===
for NET in "${BLOCK_NETS[@]}"; do
    $IPT -I OUTPUT 1 -d "$NET" -j DROP
    $IPT -I FORWARD 1 -d "$NET" -j DROP
done

# === Если nftables активен, дублируем туда ===
if [ "$NFT_ACTIVE" = true ]; then
    for NET in "${BLOCK_NETS[@]}"; do
        nft insert rule inet filter output ip daddr "$NET" drop 2>/dev/null
        nft insert rule inet filter forward ip daddr "$NET" drop 2>/dev/null
    done
fi

# === Сохраняем правила для автозагрузки ===
if command -v netfilter-persistent >/dev/null 2>&1; then
    echo "[INFO] Сохраняем через netfilter-persistent..."
    netfilter-persistent save
elif command -v service >/dev/null 2>&1 && service iptables save 2>/dev/null; then
    echo "[INFO] Сохраняем через service iptables save..."
    service iptables save
elif command -v iptables-save >/dev/null 2>&1; then
    echo "[INFO] Сохраняем в /etc/iptables/rules.v4..."
    mkdir -p /etc/iptables
    iptables-save > /etc/iptables/rules.v4
    if command -v ip6tables-save >/dev/null 2>&1; then
        ip6tables-save > /etc/iptables/rules.v6
    fi
else
    echo "[WARN] Не найден способ автосохранения правил. Установи пакет iptables-persistent."
    echo "       sudo apt install iptables-persistent"
fi

# === Проверка ===
echo "[INFO] Первые правила OUTPUT:"
$IPT -L OUTPUT -n --line-numbers | head -20
echo "[INFO] Первые правила FORWARD:"
$IPT -L FORWARD -n --line-numbers | head -20
