# Authentication Testing — Burp Suite

Authentication determines **who** a user or client is — not what they have access to (that's authorization).

---

## Common Vulnerabilities

- No MFA enforced
- Insecure / unencrypted connections (HTTP, weak TLS)
- Compromised credentials (credential stuffing)
- Logic flaws in auth flow
- Weak or absent account lockout policies

---

## Typical Attacks

| Attack | Description |
|---|---|
| Brute Force | Automated password guessing — mitigate with CAPTCHA after 3 attempts, reset status code per login request |
| Man-in-the-Middle | Intercept credentials over insecure connections |
| Token Stealing | Session/JWT theft via XSS or network sniffing |
| SIM Swapping | Hijack SMS-based MFA by porting victim's number |

---

## Mitigations

- Return the **same HTTP status code** regardless of whether username or password is wrong
- Return **generic error messages** (no "username not found" vs "wrong password")
- Enforce **uniform response times** to prevent timing-based enumeration

---

## Labs Completed

- [x] Username enumeration via different responses
