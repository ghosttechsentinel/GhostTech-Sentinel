<# 
GhostTech Sentinel © 2025 Sean Varvello. All rights reserved.
Licensed for personal use only. Redistribution or commercial use requires written permission.
#>

$configPath = "$env:USERPROFILE\Documents\ghosttech_config.txt"
$unauthLogPath = "$env:USERPROFILE\Documents\unauthorized_access.txt"
$lockdownLog = "$env:USERPROFILE\Documents\lockdown_log.txt"
$statusPath = "$env:USERPROFILE\Documents\status.txt"

function Show-IntruderWarning {
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show("Unauthorized activity detected. This device is protected by GhostTech Sentinel.", "Security Warning", "OK", "Error")
}

function Enable-Lockdown {
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1
    Disable-PSRemoting -Force
    Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
    Add-Content -Path $lockdownLog -Value "Lockdown enabled at $(Get-Date)"
    Set-Content -Path $statusPath -Value "Monitoring: ON`nLockdown: ENABLED`nLast breach: $(Get-Date)"
}

function Trigger-Lockdown {
    Enable-Lockdown
    Show-IntruderWarning
}

if (-not (Test-Path $configPath)) {
    exit
}

$config = Get-Content $configPath | ConvertFrom-StringData
$trustedSSID = $config["ssid"]
$trustedIPPrefix = $config["ipPrefix"]

while ($true) {
    $ssidLine = netsh wlan show interfaces | Select-String "^\s*SSID\s*:" | Select-Object -First 1
    $currentSSID = ($ssidLine -split ":\s*")[1].Trim()

    if ($currentSSID -ne $trustedSSID) {
        Add-Content -Path $unauthLogPath -Value "Untrusted SSID: '$currentSSID' at $(Get-Date)"
        Trigger-Lockdown
    }

    $currentIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -like "*Wi-Fi*"}).IPAddress
    if (-not $currentIP.StartsWith($trustedIPPrefix)) {
        Add-Content -Path $unauthLogPath -Value "IP mismatch: $currentIP at $(Get-Date)"
        Trigger-Lockdown
    }

    try {
        $ipInfo = Invoke-RestMethod -Uri "https://ipinfo.io/json"
        if ($ipInfo.org -match "VPN|Tor|Proxy") {
            Add-Content -Path $unauthLogPath -Value "Anonymity service detected: $($ipInfo.org) at $(Get-Date)"
            Trigger-Lockdown
        }
    } catch {}

    Start-Sleep -Seconds 30
}
