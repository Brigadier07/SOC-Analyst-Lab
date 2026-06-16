# Sysmon Installation Script
# Run as Administrator in PowerShell
# Usage: .\install-sysmon.ps1

# Step 1 - Download Sysmon config
Write-Host "[*] Downloading SwiftOnSecurity Sysmon config..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" `
    -OutFile "sysmonconfig-export.xml" `
    -UseBasicParsing

# Step 2 - Install Sysmon
Write-Host "[*] Installing Sysmon64..." -ForegroundColor Cyan
.\Sysmon64.exe -accepteula -i sysmonconfig-export.xml

# Step 3 - Verify installation
Write-Host "[*] Verifying Sysmon service..." -ForegroundColor Cyan
Get-Service Sysmon64

Write-Host "[+] Sysmon installed successfully!" -ForegroundColor Green
Write-Host "[*] Check Event Viewer: Applications and Services Logs > Microsoft > Windows > Sysmon > Operational" -ForegroundColor Yellow
