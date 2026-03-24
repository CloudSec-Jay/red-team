
<div align="center">

# red-team

![OWASP](https://img.shields.io/badge/OWASP-Top_10:2025-000000?style=flat-square&logo=owasp&logoColor=white)
![MITRE ATT&CK](https://img.shields.io/badge/MITRE-ATT%26CK-E4002B?style=flat-square)
![TLS/mTLS](https://img.shields.io/badge/TLS%2FmTLS-Attack_Labs-0078D4?style=flat-square)

Offensive exploitation feeds defensive detection. Learning and portfolio repo.
Primary repo: [cloud-security-engineer](https://github.com/CloudSec-Jay/cloud-security-engineer)

</div>

---

## Repository Structure

```
red-team/
├── purple-team/              Offensive TTPs → Wazuh detection loop
│   ├── missions/
│   │   ├── dvwa/             DVWA attack scenarios (sqli, xss, brute-force, csrf, command-injection, file-upload)
│   │   └── juice-shop/       OWASP Juice Shop missions (injection, broken-auth, broken-access, xxe, xss)
│   └── docs/
│       └── LAB_GUIDE.md      Attack execution + Wazuh verification steps
├── burp-suite/               PortSwigger Web Security Academy notes
│   ├── server-side/          SQLi, SSRF, XXE, path traversal, file upload, race conditions, command injection
│   ├── client-side/          XSS, CSRF, CORS, clickjacking, WebSockets, DOM-based vulns
│   └── advanced/             JWT, OAuth, HTTP request smuggling, cache poisoning, SSTI, prototype pollution
├── tls-mtls/                 TLS/mTLS attack labs and protocol analysis
│   ├── openssl-lab/          CA setup, cert issuance, mTLS handshake
│   ├── istio-lab/            mTLS policy in Kubernetes (manifests + policies)
│   ├── cilium-integration/   SPIFFE identity + Cilium L7 policy enforcement
│   ├── tls/                  TLS downgrade, weak cipher, cert pinning bypass
│   ├── dtls/                 DTLS attack surface (UDP-based TLS)
│   └── quic/                 QUIC protocol attack surface
├── nessus/                   Vulnerability scanning (reports, scans)
├── nmap/                     Network reconnaissance (labs, evidence)
├── wireshark/                Packet analysis (labs, pcaps)
└── evidence_template.md      Standardized finding documentation
```

---

## `purple-team/` — Offensive → Defensive Loop

Every mission answers three questions before a detection ships:

1. **What attacker behavior does this detect?** Must name a specific MITRE T-number.
2. **How would a skilled attacker evade this?** URL encoding, case variation, request splitting.
3. **What happens in the 60 seconds after the alert fires?** A defined response path is required.

| Scenario | OWASP | MITRE |
|---|---|---|
| SQL Injection (UNION, Boolean, Time-based) | A03 | T1190 |
| XSS (Reflected, Stored, DOM) | A03 | T1059.007 |
| Authentication Bypass / Brute Force | A07 | T1110 |
| IDOR / Broken Access Control | A01 | T1548 |
| Command Injection | A03 | T1059 |
| File Upload / RCE | A03 | T1190 |

Detection rules live in [`cloud-security-engineer/detection/wazuh/rules/`](https://github.com/CloudSec-Jay/cloud-security-engineer/tree/main/detection/wazuh/rules).

---

## `burp-suite/` — PortSwigger Web Security Academy

Notes and findings from PortSwigger labs. Each topic maps to OWASP and MITRE.

**Server-side:** Access control, authentication, command injection, file upload, information disclosure, NoSQL injection, path traversal, race conditions, SSRF, XXE

**Client-side:** Clickjacking, CORS, CSRF, DOM-based vulns, WebSockets, XSS

**Advanced:** Graph API, HTTP host header attacks, HTTP request smuggling, JWT attacks, OAuth, prototype pollution, SSTI, web cache poisoning, web LLM attacks

---

## `tls-mtls/` — TLS/mTLS Attack Labs

Hands-on labs covering TLS attack surface from certificate issuance through mutual authentication enforcement.

| Lab | Focus |
|---|---|
| `openssl-lab/` | CA creation, cert issuance, mTLS handshake validation |
| `istio-lab/` | Kubernetes mTLS — PeerAuthentication, AuthorizationPolicy |
| `cilium-integration/` | SPIFFE workload identity + Cilium L7 enforcement |
| `tls/` | Downgrade attacks, weak ciphers, cert pinning bypass |
| `dtls/` | UDP-based TLS attack surface |
| `quic/` | QUIC protocol security (HTTP/3) |

---

## Framework Coverage

| Area | OWASP | MITRE |
|---|---|---|
| Web app attacks | A01, A03, A07, A09 | T1059, T1110, T1190, T1548 |
| JWT / OAuth | A02, A07 | T1550.001, T1528 |
| TLS attacks | A02 | T1557 (MITM), T1040 |
| LLM / AI attacks | LLM01, LLM02 | AML.T0051 |

---

## Related Repos

- [`cloud-security-engineer`](https://github.com/CloudSec-Jay/cloud-security-engineer) — Primary: AI/ML detection, cloud infrastructure security
- [`azure-windows-security`](https://github.com/CloudSec-Jay/azure-windows-security) — Azure Entra ID, Bicep IaC, Windows detection
