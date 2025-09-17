GhostTech Sentinel – Setup Guide

Thank you for choosing GhostTech Sentinel, a native security suite designed to protect your system from unauthorized access and network threats.

SETUP INSTRUCTIONS:

1. Run GhostTech_Launcher.ps1
   - Enter your trusted Wi-Fi SSID
   - Enter your trusted IP prefix (e.g., 192.168.1.)

2. This creates ghosttech_config.txt in your Documents folder.

3. Register GhostTech_Sentinel.ps1 as a Scheduled Task:
   Open PowerShell as Administrator and run:

   $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -File 'C:\Path\To\GhostTech_Sentinel.ps1'"
   $trigger = New-ScheduledTaskTrigger -AtStartup
   Register-ScheduledTask -TaskName "GhostTechSentinel" -Action $action -Trigger $trigger -RunLevel Highest -User "$env:USERNAME"

4. Once registered, Sentinel runs silently at startup and monitors your system.

5. To test:
   - Connect to an untrusted Wi-Fi
   - Change your IP outside your trusted range
   - Use a VPN or proxy

6. Logs are saved to your Documents folder:
   - unauthorized_access.txt
   - lockdown_log.txt
   - status.txt

GhostTech Sentinel is designed for personal use only. For commercial licensing, contact the author.