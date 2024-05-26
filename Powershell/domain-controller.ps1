  Set-StrictMode -Version Latest 
  $ErrorActionPreference = "Stop"
  
  Write-Host 'Disable Password Complexity Policy'
  # Отключение политики сложности пароля
  secedit /export /cfg C:\secpol.cfg
  (gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
  secedit /configure /db C:\Windows\security\local.sdb /cfg C:\secpol.cfg /areas SECURITYPOLICY
  rm -force C:\secpol.cfg -confirm:$false

  Write-Host 'Set Admin Password'
  #Установка пароля администратора
  $adminPassword = 'packer'
  $computerName = $env:COMPUTERNAME
  $adminUser = [ADSI] "WinNT://$computerName/Administrator,User"
  $adminUser.SetPassword($adminPassword)
    
  Write-Host 'Install AD-Domain-Services'
  Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
  Add-WindowsFeature RSAT-AD-PowerShell,RSAT-AD-AdminCenter
  