  Write-Host 'Config static'
  # ��������� ������������ IP-������
  $interfaceAlias = "Ethernet 2"
  $ipAddress = "192.168.56.2"
  $prefixLength = 24
  $defaultGateway = "192.168.56.1"

  # �������� ������������� IP-������
  $existingIP = Get-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipAddress -ErrorAction SilentlyContinue
  if ($existingIP) {
    Set-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipAddress -PrefixLength $prefixLength
  } else {
    New-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipAddress -PrefixLength $prefixLength
  }

  Write-Host 'Config default getway'
  # �������� ������������� ��������, ���� �� ����
  $existingRoute = Get-NetRoute -InterfaceAlias $interfaceAlias -DestinationPrefix "0.0.0.0/0" -ErrorAction SilentlyContinue
  if ($existingRoute) {
    Remove-NetRoute -InterfaceAlias $interfaceAlias -DestinationPrefix "0.0.0.0/0" -Confirm:$false
  }

  # ��������� �������� ��� �����
  New-NetRoute -InterfaceAlias $interfaceAlias -DestinationPrefix "0.0.0.0/0" -NextHop $defaultGateway
  
  Write-Host 'Config default DNS'
  # ��������� DNS-��������
  $newDNSServers = "8.8.8.8", "4.4.4.4"
  Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses $newDNSServers