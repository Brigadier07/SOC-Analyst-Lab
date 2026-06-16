# 🔎 Suspicious Process Detection Queries

## Overview
These queries detect common attacker reconnaissance and suspicious process execution using Sysmon EventCode 1 (Process Creation).

---

## MITRE ATT&CK Mapping
- **T1057** — Process Discovery
- **T1087** — Account Discovery
- **T1082** — System Information Discovery

---

## Query 1 — Recon Commands Detection

```spl
index=main sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
| search (CommandLine="*whoami*" OR CommandLine="*net user*" OR
          CommandLine="*net localgroup*" OR CommandLine="*ipconfig*" OR
          CommandLine="*systeminfo*" OR CommandLine="*tasklist*")
| table _time, User, CommandLine, Computer
| sort -_time
```

---

## Query 2 — All Process Creation Events

```spl
index=main sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
| table _time, Image, CommandLine, User, ParentImage
| sort -_time
```

---

## Query 3 — Processes Spawned by Office Apps (Phishing indicator)

```spl
index=main sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
| search ParentImage="*WINWORD.exe" OR ParentImage="*EXCEL.exe" OR ParentImage="*OUTLOOK.exe"
| table _time, ParentImage, Image, CommandLine, User
```

---

## Query 4 — Network Connections from Suspicious Processes

```spl
index=main sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=3
| table _time, Image, DestinationIp, DestinationPort, User
| sort -_time
```
