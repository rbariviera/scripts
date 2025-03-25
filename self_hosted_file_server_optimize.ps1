Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "MaxWorkItems" -Value 65535 -Type DWORD

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "MaxThreadsPerQueue" -Value 512 -Type DWORD

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "MaxMpxCt" -Value 65535 -Type DWORD

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "MaxCmds" -Value 65535 -Type DWORD

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpNumConnections" -Value 16777214 -Type DWORD

fsutil behavior set disablelastaccess 1

Set-SmbServerConfiguration -EnableMultiChannel $true -Force
Set-SmbServerConfiguration -EnableOplocks $true -Force
Set-SmbServerConfiguration -EnableSecuritySignature $false -Force
Set-SmbServerConfiguration -EnableLeasing $true -Force
Set-SmbServerConfiguration -AsynchronousCredits 2048 -Force

#Set-SmbServerConfiguration -EnableLargeMtu $true -Force

Restart-Computer -Force