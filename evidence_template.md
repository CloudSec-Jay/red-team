# [ARTIFACT TYPE]: [Artifact Name]

**File:** `filename.md / filename.xml / filename.json`
**Scope:** [Application / Lab / Purple Team Scenario]
**Type:** [Purple Team Mission / Burp Finding / AI Security / TLS-mTLS Config]

---

## What This Does

[One paragraph. State the vulnerability class being demonstrated or defended, the attack chain, and what the artifact proves or prevents.]

---

## Attack Chain

1. **Recon** — [What the attacker enumerated]
2. **Exploit** — [What vulnerability was triggered and how]
3. **Impact** — [What the attacker achieved]
4. **Detection** — [What fired, or what was missing]
5. **Remediation** — [What control closes this]

---

## Tool Breakdown

**[Tool Name]**
- What it does in this scenario
- Specific flags or payloads used and why
- What a false positive looks like

---

## Real-World Breaches

<!-- Pre-filled: T1190 is the primary app-sec technique — exploitation of public-facing applications. Replace with the most specific sub-technique for this artifact if different (e.g. T1059.007 for XSS, T1190 for injection). -->
### T1190 — Exploit Public-Facing Application

**Story 1 — [Short title] ([Year])**
[2-4 sentences. What application was attacked, what vulnerability class, what the impact was.]
- Source: [Link or citation]

**Story 2 — [Short title] ([Year])**
[2-4 sentences.]
- Source: [Link or citation]

**Story 3 — [Short title] ([Year])**
[2-4 sentences.]
- Source: [Link or citation]

---

<!-- USER: Identify a second MITRE technique relevant to this specific attack (e.g. T1059.007 JS execution, T1110.001 brute force, T1083 file discovery) and add 3 breach stories below. -->
### [YOUR MITRE TECHNIQUE] — [Technique Name]

**Story 1 — [Short title] ([Year])**
[2-4 sentences.]
- Source: [Link or citation]

**Story 2 — [Short title] ([Year])**
[2-4 sentences.]
- Source: [Link or citation]

**Story 3 — [Short title] ([Year])**
[2-4 sentences.]
- Source: [Link or citation]

---

## Defense-in-Depth Stack

| Control | What it prevents |
|---------|-----------------|
| [This artifact] | [What this specific test or control proves/blocks] |
| [WAF / Input validation] | [What it adds] |
| [Detection rule] | [What it detects] |
| [Active response] | [What it triggers] |

---

## Framework Mapping

<!-- AUTO: OWASP A03:2025 is pre-mapped for app-sec artifacts — injection and application exploitation are the primary app-sec vulnerability classes. Replace with the most specific OWASP category for this artifact (e.g. A01 for access control, A07 for auth). -->
| OWASP Top 10:2025 | A03:2025 — Injection | [One sentence — what injection or exploitation class this artifact demonstrates or prevents] |

<!-- AUTO: T1190 pre-mapped above. Replace with the specific sub-technique for this artifact if different. -->
| MITRE ATT&CK | T1190 — Exploit Public-Facing Application | [One sentence — what exploitation this artifact tests or defends against] |

<!-- USER: Add your second MITRE technique here after identifying it in the breaches section above. -->
| MITRE ATT&CK | [YOUR TECHNIQUE] — [Name] | [One sentence] |

<!-- AUTO: Tampering is pre-mapped for app-sec artifacts — web attacks tamper with requests, inputs, and application state. Replace only if this artifact addresses a different STRIDE threat (e.g. Information Disclosure for data exfil, Spoofing for auth bypass). -->
| STRIDE | Tampering | [One sentence — how the attack manipulates application data or state] |
