# 🧪 Lab Guide: Purple Team AppSec Detection & Response
> **Technical Standard Operating Procedure (SOP) for Lab Execution**

## 🏁 Prerequisites

### 🏗️ Infrastructure (via `IaC` Library)
All vulnerable assets are provisioned using Docker Compose from the central repository.
- **Location:** `IaC/Docker/compose_files/`
- **Command:** `docker-compose -f ../IaC/Docker/compose_files/dvwa-docker-compose.yaml up -d`

### 🛡️ Detection Platform (Wazuh)
- **Wazuh Manager:** Fully deployed and receiving logs via agent/syslog.
- **Custom Rules:** `appsec-detection/wazuh-setup/xml-rules/local_rules.xml` applied and manager restarted.

---

## 🏗️ Network Architecture (Lab Segment)

```text
       [ KALI LINUX ] (Attacker)
              │
       ┌──────▼──────┐
       │     VLAN    │ (Isolated VLAN)
       └──────┬──────┘
              │
      ┌───────┼───────┐
      ▼       ▼       ▼
   [DVWA] [JUICE] [CUSTOM]
      │       │       │
      └───────┼───────┘
              │ (Forwarded Logs)
       ┌──────▼──────┐
       │   WAZUH     │ (Detection & Response)
       └─────────────┘
```

---

## 🗡️ Scenario 1: SQL Injection (SQLi)

### 🔴 Offensive Strategy (Red Team)
1. **Target:** DVWA Login Page or Search Form.
2. **Tools:** Burp Suite Professional (Intruder), SQLMap.
3. **Payload:**
   ```sql
   ' OR 1=1 --
   ' UNION SELECT user, password FROM users --
   ```

### 🔵 Defensive Monitoring (Blue Team)
- **Wazuh Rule ID:** `100001` (SQL Injection attempt)
- **Log Source:** `/var/log/dvwa/apache/access.log`
- **Expected Alert Level:** 10+ (Critical)

### ✅ Verification Steps
1. Run the payload via Burp Suite.
2. **Check Wazuh Alert:** `tail -f /var/ossec/logs/alerts/alerts.log | grep "SQL Injection"`
3. **Verify Active Response:** `grep "firewall-drop" /var/ossec/logs/active-responses.log`
4. Confirm the attacker IP is dropped from `iptables -L`.

---

## 🗡️ Scenario 2: Cross-Site Scripting (XSS)

### 🔴 Offensive Strategy (Red Team)
1. **Target:** Guestbook (Stored XSS) or Search (Reflected XSS).
2. **Tools:** Burp Suite Professional, CyberChef.
3. **Payload:**
   ```html
   <script>alert('XSS');</script>
   <img src=x onerror=alert(1)>
   ```

### 🔵 Defensive Monitoring (Blue Team)
- **Wazuh Rule ID:** `100002` (XSS payload detected)
- **Log Source:** Application layer logs via Wazuh Agent.
- **Expected Alert Level:** 10+ (Critical)

### ✅ Verification Steps
1. Submit the XSS payload.
2. Observe the alert firing in the Wazuh Dashboard.
3. Verify the payload is sanitized in the UI (if applicable) OR the active response has rate-limited the attacker.

---

## ⚡ Active Response Tuning

### Idempotency Check
Every response script must be idempotent.
- **Command:** `python3 active-response-scripts/python-scripts/python-trigger.py <test-parameters>`
- **Expected:** Second execution does not create duplicate firewall rules.

### Forensic Preservation
Before a host is isolated, the `snapshot_logs.sh` script must be verified.
- **Verification:** Confirm `.tar.gz` log bundle exists in `/tmp/forensics/` before the `iptables` drop.

---

## 🛠️ Troubleshooting

- **Logs not reaching Wazuh:** Verify `ossec.conf` file paths and permissions.
- **Rules not firing:** Use `/var/ossec/bin/wazuh-logtest` to test raw log lines against your XML rules.
- **Active Response failure:** Check `/var/ossec/logs/active-responses.log` for permission errors (script must be executable by `wazuh` user).

---

## 📊 Roadmap: Next Lab Runs
- [ ] Scenario 3: JWT Algorithm Confusion (`alg: none`)
- [ ] Scenario 4: Broken Access Control (IDOR)
- [ ] Scenario 5: Command Injection (DVWA Ping tool)
