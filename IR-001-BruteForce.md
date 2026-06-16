# 📋 Incident Report — IR-001
## Brute Force Attack on Windows Endpoint

---

| Field | Details |
|---|---|
| **Incident ID** | IR-001 |
| **Date** | June 15, 2026 |
| **Severity** | High |
| **Status** | Resolved |
| **Analyst** | SOC Home Lab |
| **MITRE Technique** | T1110 — Brute Force |

---

## 1. Executive Summary

On June 15, 2026, Splunk SIEM detected multiple failed authentication attempts against a Windows 10 endpoint. A total of 9 failed login events (EventCode 4625) were recorded within a 30-second window, targeting the user account `vitim` on host `windows10`. This pattern is consistent with an automated brute force attack.

---

## 2. Timeline of Events

| Time (UTC+5:30) | Event | EventCode |
|---|---|---|
| 07:28:17 | Failed login attempt #1 | 4625 |
| 07:28:19 | Failed login attempt #2 | 4625 |
| 07:28:22 | Failed login attempt #3 | 4625 |
| 07:28:26 | Failed login attempt #4 | 4625 |
| 07:28:28 | Failed login attempt #5 | 4625 |
| 07:28:30 | Failed login attempt #6 | 4625 |

---

## 3. Detection Details

**Alert Triggered:** `Brute Force Detection - Failed Logins`

**Splunk Query Used:**
```spl
index=main EventCode=4625 earliest=0
| stats count by Account_Name, ComputerName
| sort -count
```

**Results:**
| Account_Name | ComputerName | Failed Attempts |
|---|---|---|
| vitim | windows10 | 6 |
| WINDOWS10$ | windows10 | 3 |

---

## 4. Affected Assets

| Asset | Details |
|---|---|
| **Hostname** | windows10 |
| **OS** | Windows 10 |
| **Targeted Account** | vitim |
| **Log Source** | WinEventLog:Security |

---

## 5. Analysis

The failed login attempts occurred in rapid succession (every 2-4 seconds), which is inconsistent with normal human typing behavior. This pattern strongly suggests an automated tool was used to attempt multiple passwords against the `vitim` account.

**Key Indicators:**
- 6 failed logins within 13 seconds
- All attempts targeting the same account
- No successful login following the failures

---

## 6. Response Actions Taken

- [x] Identified targeted account (`vitim`)
- [x] Confirmed no successful login after failed attempts
- [x] Created Splunk alert to trigger on future brute force attempts
- [x] Documented incident in this report

---

## 7. Recommendations

1. **Enable Account Lockout Policy** — Lock account after 5 failed attempts
2. **Enable MFA** — Add multi-factor authentication for all accounts
3. **Monitor for lateral movement** — Check if attacker moved to other systems
4. **Review privileged accounts** — Ensure admin accounts have strong passwords

---

## 8. Lessons Learned

This exercise demonstrated how quickly a brute force attack can be detected using Windows Security logs and a properly configured SIEM. The key was having EventCode 4625 ingested into Splunk with a threshold alert set to trigger after 5 failures.

---

*Report prepared as part of SOC Analyst Home Lab — Project 1: SIEM Log Monitoring & Threat Detection*
