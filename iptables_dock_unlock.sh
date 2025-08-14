#!/bin/bash
set -e

# === Сети для удаления правил ===
BLOCK_NETS=(
    "172.16.0.0/12"
    "192.168.0.0/16"
    "198.18.0.0/15"
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

# === Удаляем правила из iptables ===
for NET in "${BLOCK_NETS[@]}"; do
    for CHAIN in OUTPUT FORWARD INPUT; do
        while $IPT -D $CHAIN -d "$NET" -j DROP 2>/dev/null; do
            echo "[DEL] Удалено правило DROP для $NET из $CHAIN"
        done
    done
done

# === Удаляем из nftables, если есть ===
if [ "$NFT_ACTIVE" = true ]; then
    for NET in "${BLOCK_NETS[@]}"; do
        nft delete rule inet filter output ip daddr "$NET" drop 2>/dev/null || true
        nft delete rule inet filter forward ip daddr "$NET" drop 2>/dev/null || true
        nft delete rule inet filter input ip saddr "$NET" drop 2>/dev/null || true
    done
fi

# === Сохраняем изменения ===
if command -v netfilter-persistent >/dev/null 2>&1; then
    netfilter-persistent save
elif command -v service >/dev/null 2>&1 && service iptables save 2>/dev/null; then
    service iptables save
elif command -v iptables-save >/dev/null 2>&1; then
    mkdir -p /etc/iptables
    iptables-save > /etc/iptables/rules.v4
    if command -v ip6tables-save >/dev/null 2>&1; then
        ip6tables-save > /etc/iptables/rules.v6
    fi
fi

echo "[OK] Все правила DROP для заданных сетей удалены."
