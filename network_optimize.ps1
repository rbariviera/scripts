## Optimize Network Performance
#Now that ENA is enabled, make sure your instance is configured for maximum network performance:

#Enable Receive Side Scaling (RSS):
Set-NetAdapterRss -Name "*" -Enabled $true


## Optimize TCP/IP Stack for High Performance

# Enable TCP Receive Window Auto-Tuning
netsh int tcp set global autotuninglevel=experimental

# Enable TCP timestamps for better congestion control
netsh int tcp set global timestamps=enabled

# Increase dynamic port range for more outbound connections
netsh int ipv4 set dynamicport tcp start=49152 num=16384

# Enable Receive Side Scaling (RSS) to use multiple CPU cores
Set-NetAdapterRss -Name "*" -Enabled $true

# Optimize TCP Congestion Control
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set supplemental internet congestionprovider=ctcp
netsh int tcp set global ecncapability=enabled

# Tune Windows Server for High Network Traffic
# Modify registry settings to allow more connections:
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpNumConnections" -Value 16777214 -PropertyType DWord -Force


## Enable TCP Keep-Alive for Aurora
#Aurora Serverless closes idle connections quickly. Set TCP Keep-Alive to keep connections open:

New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "KeepAliveTime" -Value 300000 -PropertyType DWord -Force


## FSx for Windows File Sharing Optimization
# FSx for Windows uses SMB, which has tunable performance settings.

# Enable SMB Multichannel
# SMB Multichannel increases bandwidth and fault tolerance:

Set-SmbServerConfiguration -EnableMultiChannel $true -Confirm:$false

# Disable SMB Signing (If Security Allows)
# Disabling SMB signing can reduce overhead:

Set-SmbServerConfiguration -EnableSecuritySignature $false -Confirm:$false

Set-SmbClientConfiguration -EnableMultiChannel $true -Force -Confirm:$false

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "MaxCmds" -Value 65535 -Type DWORD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "MaxMpxCt" -Value 65535 -Type DWORD

Restart-Service LanmanWorkstation

Set-SmbClientConfiguration -SessionTimeout 30 -Force -Confirm:$false

Restart-Computer -Force -Confirm:$false
