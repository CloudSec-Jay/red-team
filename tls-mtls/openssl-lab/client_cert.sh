#!/bin/bash
set -euo pipefail
# Runs on: tls-ca
# Input:   client.csr (copied from tls-client)
# Output:  client.crt (copy back to tls-client)

CLIENT_CN="tls-client"

# CA signs the client CSR
# extendedKeyUsage=clientAuth — cert is only valid for client authentication
# Without this, a server cert cannot be presented as a client cert
openssl x509 -req -days 90 \
  -in client.csr \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -out client.crt \
  -sha256 \
  -extfile <(printf "extendedKeyUsage=clientAuth\nsubjectAltName=DNS:%s" "$CLIENT_CN")

echo "client.crt ready — copy to tls-client"
echo "Verify: openssl x509 -in client.crt -noout -text | grep -A1 'Extended Key Usage'"
