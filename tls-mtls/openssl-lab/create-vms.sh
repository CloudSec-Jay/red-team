#!/bin/bash
# create-vms.sh — Provision 3 Ubuntu 24.04 Server VMs on lab-net for TLS/mTLS lab
# VMs: tls-ca (CA), tls-server (nginx+mTLS), tls-client (curl/openssl testing)
#
# Network: lab-net — 192.168.100.0/24 (isolated, no internet by design)
#   tls-ca      192.168.100.10
#   tls-server  192.168.100.11
#   tls-client  192.168.100.12
#
# NOTE: Uses live ISO installer + VNC. VM will have no network until Ubuntu
# installer completes and netplan is configured.
# Preferred approach: use Ubuntu 24.04 cloud image (pre-installed qcow2) with
# --cloud-init user-data to inject netplan config, hostname, and SSH key at launch.
#
# Run as: sudo bash create-vms.sh

set -euo pipefail

ISO="/home/jayadmin/Downloads/ubuntu-24.04.3-live-server-amd64.iso"
IMG_DIR="/var/lib/libvirt/images"
NETWORK="lab-net"
RAM=1024
VCPUS=1
DISK_GB=10
OS_VARIANT="ubuntu24.04"

VMAS=("tls-ca" "tls-server" "tls-client")

for VM in "${VMAS[@]}"; do
    DISK="${IMG_DIR}/${VM}.qcow2"

    if virsh dominfo "$VM" &>/dev/null; then
        echo "[SKIP] $VM already exists"
        continue
    fi

    echo "[CREATE] $VM — disk: $DISK"

    virt-install \
        --name "$VM" \
        --ram "$RAM" \
        --vcpus "$VCPUS" \
        --disk path="$DISK",size="$DISK_GB",format=qcow2 \
        --cdrom "$ISO" \
        --network network="$NETWORK" \
        --os-variant "$OS_VARIANT" \
        --graphics vnc \
        --noautoconsole

    echo "[OK] $VM created — connect with: virt-viewer $VM"
done

echo ""
echo "All VMs provisioned. List:"
virsh list --all | grep -E "tls-"
