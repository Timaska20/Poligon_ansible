  $adminPassword = 'packer'
  
  Import-Module ADDSDeployment
  
  
  Install-ADDSForest `
    -SafeModeAdministratorPassword (ConvertTo-SecureString $adminPassword -asplaintext -force) `
    -DomainName "example.com" `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "7" `
    -DomainNetbiosName "EXAMPLE" `
    -ForestMode "7" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true


  Write-Host "Start sleeping until reboot to prevent vagrant connection failures..."
  
while ($true) {
    try {
        Get-ADDomain | Out-Null
        break
    } catch {
        Start-Sleep -Seconds 10
    }
}