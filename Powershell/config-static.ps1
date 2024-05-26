  Write-Host 'Config static'
  # Настройка статического IP-адреса
  $interfaceAlias = "Ethernet 2"
  $ipAddress = "192.168.56.2"
  $prefixLength = 24
  $defaultGateway = "192.168.56.1"

  # Проверка существования IP-адреса
  $existingIP = Get-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipAddress -ErrorAction SilentlyContinue
  if ($existingIP) {
    Set-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipAddress -PrefixLength $prefixLength
  } else {
    New-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipAddress -PrefixLength $prefixLength
  }

  Write-Host 'Config default getway'
  # Удаление существующего маршрута, если он есть
  $existingRoute = Get-NetRoute -InterfaceAlias $interfaceAlias -DestinationPrefix "0.0.0.0/0" -ErrorAction SilentlyContinue
  if ($existingRoute) {
    Remove-NetRoute -InterfaceAlias $interfaceAlias -DestinationPrefix "0.0.0.0/0" -Confirm:$false
  }

  # Установка маршрута для шлюза
  New-NetRoute -InterfaceAlias $interfaceAlias -DestinationPrefix "0.0.0.0/0" -NextHop $defaultGateway
  
  Write-Host 'Config default DNS'
  # Настройка DNS-серверов
  $newDNSServers = "8.8.8.8", "4.4.4.4"
  Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses $newDNSServers