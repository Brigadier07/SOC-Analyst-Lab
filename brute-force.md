# 🔐 Brute Force Detection Queries

## Overview
These Splunk SPL queries detect brute force login attempts against Windows machines by monitoring failed authentication events.

---

## MITRE ATT&CK Mapping
- **Technique:** T1110 — Brute Force
- **Sub-technique:** T1110.001 — Password Guessing
- **Tactic:** Credential Access

---

## Query 1 — Basic Failed Login Detection

```spl
index=main EventCode=4625 earliest=0
| stats count by Account_Name, ComputerName
| sort -count
```

**What it does:** Counts all failed login attempts grouped by account and computer name.

**Expected output:**
| Account_Name | ComputerName | count |
|---|---|---|
| vitim | windows10 | 6 |
| WINDOWS10$ | windows10 | 3 |

---

## Query 2 — Brute Force Alert (5+ failures)

```spl
index=main EventCode=4625 earliest=0
| stats count by Account_Name, ComputerName
| where count > 5
| sort -count
```

**What it does:** Flags accounts with more than 5 failed login attempts — a strong indicator of brute force.

---

## Query 3 — Timeline of Attacks

```spl
index=main EventCode=4625 earliest=0
| table _time, Account_Name, ComputerName, Failure_Reason
| sort _time
```

**What it does:** Shows exact timestamps of each failed login attempt to identify attack patterns.

---

## Query 4 — Failed then Successful Login (Potential Compromise)

```spl
index=main (EventCode=4625 OR EventCode=4624) earliest=0
| stats count(eval(EventCode=4625)) as failures,
        count(eval(EventCode=4624)) as successes
        by Account_Name, ComputerName
| where failures > 3 AND successes > 0
```

**What it does:** Detects accounts that had multiple failures followed by a success — may indicate successful brute force compromise.

---

## Alert Configuration

| Setting | Value |
|---|---|
| Alert Name | Brute Force Detection - Failed Logins |
| Schedule | Every hour |
| Trigger | Number of results > 5 |
| Severity | High |
| Action | Add to Triggered Alerts |

---

## Investigation Steps

When this alert fires:
1. Identify the targeted `Account_Name`
2. Check if the account later had a successful login (EventCode 4624)
3. Review the source IP if available in the logs
4. Check what the account did after logging in (EventCode 4688 — process creation)
5. Document findings in an incident report

---

## Lab Results

During testing, I simulated a brute force attack by entering wrong passwords 9 times on the Windows 10 VM. Splunk detected all 9 failed attempts and the alert fired correctly.

**Finding:** Account `vitim` on `windows10` had 6 failed login attempts within 30 seconds — consistent with automated brute force behavior.
