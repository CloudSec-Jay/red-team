# Mission: [Lab Name from PortSwigger]

## 🎯 Target Overview
- **Source:** PortSwigger Web Security Academy
- **Vulnerability Class:** [e.g., SQL Injection, XSS]
- **Severity:** [Low / Medium / High / Critical]
- **Target OS:** [Linux / Windows]

---

## 🗡️ Offensive Phase (The Solve)

### 1. Discovery
Describe how you found the vulnerability using Burp Suite (e.g., "Fuzzed the `category` parameter in the URL").

### 2. Exploitation
Provide the exact payload used to solve the lab.
```http
GET /filter?category=Gifts' UNION SELECT NULL,username,password FROM users--
```

### 3. Proof of Concept (PoC)
[Link to screenshot in /evidence/scenarios/ showing the solved lab]

---

## 🛡️ Defensive Phase (The Detection)

### 1. Log Analysis
What does the attack look like in the raw web server logs?
```text
192.168.1.5 - - [25/Feb/2026:10:00:01] "GET /filter?category=Gifts%27%20UNION%20SELECT... HTTP/1.1" 200
```

### 2. Wazuh Rule Logic
The custom rule created to detect this specific TTP.
- **Rule ID:** [e.g., 100201]
- **File Path:** `detections/rules/[os]/local_rules.xml`

### 3. Active Response
Did this trigger an automated block? (e.g., "IP 192.168.1.5 was added to iptables drop list").

---

## 🎓 Senior Review Notes
- **Evasion Surface:** How could an attacker bypass this rule? (e.g., "Double URL encoding").
- **Mitigation:** Beyond detection, how should the code be fixed? (e.g., "Use Parameterized Queries").
