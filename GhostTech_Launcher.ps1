<# 
GhostTech Sentinel Launcher © 2025 Sean Varvello. All rights reserved.
Licensed for personal use only. Redistribution or commercial use requires written permission.
#>

Write-Host "`n██████╗  ██████╗  ██████╗ ████████╗████████╗██╗  ██╗"
Write-Host "██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝╚══██╔══╝██║  ██║"
Write-Host "██████╔╝██║   ██║██║   ██║   ██║      ██║   ███████║"
Write-Host "██╔═══╝ ██║   ██║██║   ██║   ██║      ██║   ██╔══██║"
Write-Host "██║     ╚██████╔╝╚██████╔╝   ██║      ██║   ██║  ██║"
Write-Host "╚═╝      ╚═════╝  ╚═════╝    ╚═╝      ╚═╝   ╚═╝  ╚═╝"
Write-Host "GhostTech Sentinel – Native Security Suite`n"

$ssid = Read-Host "Enter your trusted Wi-Fi SSID"
$ipPrefix = Read-Host "Enter your trusted IP prefix (e.g., 192.168.1.)"

@"
ssid=$ssid
ipPrefix=$ipPrefix
"@ | Set-Content "$env:USERPROFILE\Documents\ghosttech_config.txt"

Write-Host "`n✅ Configuration saved. You may now register GhostTech_Sentinel.ps1 as a Scheduled Task."
