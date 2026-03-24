#!/bin/bash
set -euo pipefail
# Runs on: tls-ca
# Input:   server.csr (copied from tls-server)
# Output:  server.crt (copy back to tls-server)

SERVER_IP="192.168.100.11"
SERVER_CN="tls-server"

# Step 1 — CA signs the server CSR
# Requires: ca.crt, ca.key (on tls-ca), server.csr (from tls-server)
# -days 90 — short-lived leaf cert, limits blast radius if compromised
# subjectAltName — required by modern TLS; cert is rejected without it
openssl x509 -req -days 90 \
  -in server.csr \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -out server.crt \
  -sha256 \
  -extfile <(printf "subjectAltName=DNS:%s,IP:%s" "$SERVER_CN" "$SERVER_IP")

echo "server.crt ready — copy to tls-server"
echo "Verify: openssl x509 -in server.crt -noout -text | grep -A1 'Subject Alternative'"
