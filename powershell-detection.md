# 💻 PowerShell Suspicious Activity Detection

## Overview
Attackers commonly abuse PowerShell for execution, discovery, and lateral movement. These queries detect suspicious PowerShell usage via Sysmon process creation logs.

---

## MITRE ATT&CK Mapping
- **Technique:** T1059.001 — Command and Scripting Interpreter: PowerShell
- **Tactic:** Execution

---

## Query 1 — Encoded PowerShell Commands

```spl
index=main sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
| search CommandLine="*powershell*" AND (CommandLine="*-enc*" OR CommandLine="*-EncodedCommand*")
| table _time, User, CommandLine, ParentImage
```

**What it does:** Detects PowerShell running encoded commands — a common attacker technique to hide malicious code.

---

## Query 2 — PowerShell Downloading Files

```spl
index=main sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
| search CommandLine="*powershell*" AND (CommandLine="*DownloadFile*" OR CommandLine="*Invoke-WebRequest*" OR CommandLine="*WebClient*")
| table _time, User, CommandLine
```

**What it does:** Detects PowerShell being used to download files from the internet — common in malware droppers.

---

## Query 3 — Suspicious Recon Commands

```spl
index=main sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
| search (CommandLine="*whoami*" OR CommandLine="*net user*" OR CommandLine="*net localgroup*" OR CommandLine="*ipconfig*")
| table _time, User, CommandLine, Computer
| sort _time
```

**What it does:** Detects common attacker reconnaissance commands run on the system.

---

## Query 4 — All PowerShell Execution

```spl
index=main sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
Image="*powershell.exe"
| table _time, User, CommandLine, ParentImage
| sort -_time
```

**What it does:** Shows all PowerShell executions for manual review.

---

## Alert Configuration

| Setting | Value |
|---|---|
| Alert Name | Suspicious PowerShell Execution |
| Schedule | Real-time |
| Trigger | Number of results > 0 |
| Severity | Medium-High |
| Action | Add to Triggered Alerts |
