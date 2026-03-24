# 🕵️ Purple Team

<div align="center">

![OWASP](https://img.shields.io/badge/OWASP-Top_10:2025-000000?style=flat-square&logo=owasp&logoColor=white)
![MITRE](https://img.shields.io/badge/MITRE-ATT%26CK_Cloud-E4002B?style=flat-square)
![Wazuh](https://img.shields.io/badge/Wazuh-XDR%2FSIEM-3CBCE8?style=flat-square&logo=wazuh&logoColor=white)

**Offensive TTPs feed defensive detections. Every mission answers three questions.**

</div>

---

## 🎯 Three-Question Gate

No detection ships without passing:

1. **What attacker behavior does this detect?** — Must name a specific MITRE T-number.
2. **How would a skilled attacker evade this?** — URL encoding, case variation, request splitting.
3. **What happens in the 60 seconds after the alert fires?** — A defined active response path is required.

---

## 🏗️ Structure

```
red-team/purple-team/
├── missions/
│   └── MISSION_TEMPLATE.md   ← Standardized offensive→defensive doc loop
└── docs/
    └── LAB_GUIDE.md          ← Attack scenarios, Wazuh verification, active response testing
```

---

## 🔗 Attack-to-Detection Loop

Purple team missions flow directly into `detection/`:

```
Mission executes TTP
 → Log evidence captured (auth.log / Apache / auditd)
  → Wazuh rule fires with MITRE tag + severity
   → Active response triggers (if configured)
    → GAPS block documents adjacent uncovered techniques
```

**Rule artifacts live in** [`detection/wazuh/rules/`](../../detection/wazuh/rules/) — not here.
**Active response scripts live in** [`detection/wazuh/active-response/`](../../detection/wazuh/active-response/).

---

## 📋 Attack Scenarios Covered

| Scenario | OWASP | MITRE | Detection Rule Range |
|----------|-------|-------|---------------------|
| SQL Injection (UNION, Boolean, Time-based) | A03 | T1190 | 100200–100299 |
| XSS (Reflected, Stored, DOM) | A03 | T1059.007 | 100200–100299 |
| Authentication Bypass / Brute Force | A07 | T1110 | 100400–100499 |
| IDOR / Broken Access Control | A01 | T1548 | 100001–100099 |
| Command Injection | A03 | T1059 | 100200–100299 |
| File Inclusion (LFI/RFI) | A03 | T1083 | 100200–100299 |

---

## 🧪 Lab Environment

DVWA (Damn Vulnerable Web Application) is the target host. Wazuh agent runs on the DVWA VM — host-level visibility, not inside the container.

See [`docs/LAB_GUIDE.md`](docs/LAB_GUIDE.md) for setup, attack execution, and Wazuh verification steps.
