# OpenSSL TLS/mTLS Lab

## Lab Topology

```
lab-net: 192.168.100.0/24 (isolated — no internet)

  tls-ca      192.168.100.10  — Root CA (signs all certs)
  tls-server  192.168.100.11  — nginx, presents server cert, validates client cert (mTLS)
  tls-client  192.168.100.12  — curl/openssl s_client, presents client cert (mTLS)
```

All VMs run on libvirt `lab-net`. No internet access by design — VMs only communicate with each other.
VM provisioning uses Ubuntu 24.04 cloud image + cloud-init (not the live installer).

---

## What is TLS?

Transport Layer Security — encrypts traffic between two parties.

**TLS handshake (TLS 1.3):**
1. Client hello — supported cipher suites, key share
2. Server hello — chosen cipher, server certificate
3. Client validates server cert against trusted CA
4. Session keys derived (ECDHE — forward secrecy)
5. Encrypted channel established

**Key point:** Server proves its identity. Client is anonymous — the server trusts anyone the CA trusted.

---

## What is mTLS?

Mutual TLS — both sides present certificates. Both sides are authenticated.

**Difference from TLS:**
- Client also holds a cert signed by the CA
- Server validates the client cert before allowing the connection
- No anonymous clients — every connection is attributable

**When to use:**
- TLS only — public web apps (browsers can't carry client certs easily)
- mTLS — service-to-service, internal APIs, zero trust east-west traffic

**Zero Trust relevance:** mTLS enforces "Verify Explicitly" at the transport layer.
Cilium uses this transparently between pods. This lab demonstrates it manually with OpenSSL.

---

## What is OpenSSL?

Open-source toolkit for TLS and PKI operations.
Used here to: generate keys, create a CA, sign certificates, and test TLS/mTLS connections.

---

## Scripts

| Script | Runs on | Purpose |
|---|---|---|
| `openssl.sh` | tls-ca | Create root CA key + self-signed cert |
| `server_cert.sh` | tls-ca | Sign server CSR → produce server.crt |
| `client_cert.sh` | tls-ca | Sign client CSR → produce client.crt |
| `create-vms.sh` | Fedora host | Provision 3 libvirt VMs on lab-net |

---

## Attack Surface (MITRE)

| Attack | MITRE ID | Mitigation |
|---|---|---|
| Adversary-in-the-Middle | T1557.002 | mTLS — both sides authenticated, MitM cannot present valid cert |
| Downgrade attack | T1600.001 | TLS 1.3 only — no fallback to 1.2/1.1 |
| Stolen client cert | T1552.004 | Short-lived certs (90 days), CRL/OCSP revocation |
| Compromised CA | T1553.004 | CA key stored encrypted (AES-256), offline when not signing |
| mTLS bypass via misconfiguration | T1557 | Test with openssl s_client — verify both certs validated |

---

## Lab Steps

### 1. On tls-ca — build the CA
```bash
bash openssl.sh
# outputs: ca.key (keep private), ca.crt (copy to server and client)
```

### 2. On tls-server — generate key + CSR, send CSR to CA
```bash
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr -subj "/CN=tls-server/O=Lab/C=GB"
# copy server.csr to tls-ca
```

### 3. On tls-ca — sign server CSR
```bash
bash server_cert.sh
# outputs: server.crt — copy back to tls-server
```

### 4. On tls-client — generate key + CSR, send CSR to CA
```bash
openssl genrsa -out client.key 4096
openssl req -new -key client.key -out client.csr -subj "/CN=tls-client/O=Lab/C=GB"
# copy client.csr to tls-ca
```

### 5. On tls-ca — sign client CSR
```bash
bash client_cert.sh
# outputs: client.crt — copy back to tls-client
```

### 6. Test TLS (server auth only)
```bash
# from tls-client
openssl s_client -connect tls-server:443 -CAfile ca.crt
```

### 7. Test mTLS (mutual auth)
```bash
# from tls-client
openssl s_client -connect tls-server:443 \
  -CAfile ca.crt \
  -cert client.crt \
  -key client.key
```

---

## MITRE / OWASP Mapping

- MITRE: T1557 (Adversary-in-the-Middle), T1040 (Network Sniffing), T1553.004 (Subvert Trust Controls)
- OWASP: A02:2021 Cryptographic Failures, A07:2021 Identification and Authentication Failures
- NIST: SC-8 (Transmission Confidentiality), SC-17 (PKI Certificates)
