#!/bin/bash
set -euo pipefail

# Step 1 — Generate CA private key (AES-256 encrypted at rest)
# Passphrase protects ca.key on disk — required every time you sign a cert
openssl genrsa -aes256 -out ca.key 4096

# Step 2 — Generate self-signed CA certificate
# basicConstraints=critical,CA:TRUE — this cert is allowed to sign others
# keyUsage=critical,keyCertSign,cRLSign — CA can only sign certs and revocation lists
# critical — clients must reject the cert if they don't understand these extensions
openssl req -new -x509 -days 3650 \
  -key ca.key \
  -out ca.crt \
  -sha256 \
  -subj "/CN=LabRootCA/O=Lab/C=GB" \
  -addext "basicConstraints=critical,CA:TRUE" \
  -addext "keyUsage=critical,keyCertSign,cRLSign"

# Distribute ca.crt to tls-server and tls-client — this is the trust anchor
# ca.key stays on tls-ca and never leaves
echo "CA ready: ca.key (keep private on tls-ca) ca.crt (copy to tls-server and tls-client)"
