# 🛡️ SOC Analyst Home Lab

<p align="center">
  <img src="https://img.shields.io/badge/SIEM-Splunk-black?style=for-the-badge&logo=splunk&logoColor=green" />
  <img src="https://img.shields.io/badge/OS-Windows%2010-blue?style=for-the-badge&logo=windows" />
  <img src="https://img.shields.io/badge/Tool-Sysmon-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Platform-VirtualBox-blue?style=for-the-badge&logo=virtualbox" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge" />
</p>

---

## 📌 Overview

This repository documents my SOC Analyst home lab, built to simulate real-world cyber attacks and detect them using industry-standard tools. The lab replicates a Tier 1–2 SOC environment where I ingest logs, write detection rules, investigate incidents, and produce findings — just like a working SOC analyst.

---

## 🏗️ Lab Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     HOST MACHINE                        │
│                                                         │
│   ┌─────────────────────┐                               │
│   │   Splunk Enterprise │  ◄── Receives logs on :9997  │
│   │   (SIEM)            │                               │
│   │   localhost:8000    │                               │
│   └─────────────────────┘                               │
│              ▲                                          │
│              │ Log forwarding (TCP 9997)                │
│              │                                          │
│   ┌──────────┴──────────────────────────────────┐       │
│   │           VIRTUALBOX VMs                    │       │
│   │                                             │       │
│   │  ┌─────────────────┐  ┌─────────────────┐  │       │
│   │  │  Windows 10 VM  │  │  Kali Linux VM  │  │       │
│   │  │  (Victim/Target)│  │  (Attacker)     │  │       │
│   │  │                 │  │                 │  │       │
│   │  │  • Sysmon       │  │  • Nmap         │  │       │
│   │  │  • UF Forwarder │  │  • Metasploit   │  │       │
│   │  │  • Windows Logs │  │  • SET Toolkit  │  │       │
│   │  └─────────────────┘  └─────────────────┘  │       │
│   └─────────────────────────────────────────────┘       │
└─────────────────────────────────────────────────────────┘
```

---

## 🧰 Tools & Technologies

| Category | Tool | Purpose |
|---|---|---|
| SIEM | Splunk Enterprise | Log ingestion, detection, alerting |
| Telemetry | Sysmon v15 | Advanced Windows event logging |
| Virtualization | VirtualBox | VM hosting |
| Target OS | Windows 10 | Log source / victim machine |
| Attack OS | Kali Linux 2026 | Attack simulation |
| Log Forwarding | Splunk Universal Forwarder | Ship logs from VM to Splunk |
| Config | SwiftOnSecurity Sysmon Config | Optimized Sysmon ruleset |

---

## 📁 Repository Structure

```
SOC-Analyst-Lab/
│
├── README.md                  # This file — lab overview
│
├── detection-queries/         # All Splunk SPL detection queries
│   ├── brute-force.md
│   ├── powershell-detection.md
│   ├── privilege-escalation.md
│   └── suspicious-processes.md
│
├── reports/                   # Incident investigation reports
│   ├── IR-001-BruteForce.md
│   └── IR-002-PowerShell.md
│
├── scripts/                   # Setup and automation scripts
│   ├── install-sysmon.ps1
│   └── splunk-inputs.conf
│
└── screenshots/               # Evidence screenshots
    └── [lab screenshots]
```

---

## 🔬 Projects Completed

### ✅ Project 1 — SIEM Log Monitoring & Threat Detection
> **Status: Complete

Built a fully functional SIEM lab using Splunk Enterprise. Configured Windows 10 VM with Sysmon for advanced telemetry, set up Universal Forwarder to ship logs to Splunk, and created detection rules for real attack techniques.

📂 [View Detection Queries](./detection-queries/) | 📄 [View Incident Reports](./reports/)

---

### 🔄 Project 2 — Phishing Attack & Incident Response *(Coming Soon)*
### 🔄 Project 3 — IDS Deployment & Packet Analysis *(Coming Soon)*
### 🔄 Project 4 — Cloud Security Monitoring *(Coming Soon)*

---

## 🎯 MITRE ATT&CK Coverage

| Technique ID | Technique Name | Detection Method |
|---|---|---|
| T1110 | Brute Force | EventCode 4625 — Failed Logons |
| T1078 | Valid Accounts | EventCode 4624 — Successful Logons |
| T1059.001 | PowerShell | Sysmon EventCode 1 — Process Creation |
| T1057 | Process Discovery | Sysmon EventCode 1 — whoami, tasklist |
| T1087 | Account Discovery | Sysmon EventCode 1 — net user |

---

## 📊 Skills Demonstrated

- ✅ SIEM deployment and configuration (Splunk)
- ✅ Windows Event Log analysis
- ✅ Sysmon telemetry and rule tuning
- ✅ SPL (Splunk Processing Language) query writing
- ✅ Threat detection rule creation
- ✅ Alert configuration and tuning
- ✅ Incident documentation and reporting
- ✅ MITRE ATT&CK framework mapping
- ✅ Virtual lab environment setup

---

## 📬 Connect With Me

> *This lab is actively maintained and updated as I complete more SOC projects.*

