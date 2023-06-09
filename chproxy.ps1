$IP='127.0.0.1'
$PORT='8888'
function proxyOnOff {
    $value=Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyEnable
    if ($value.ProxyEnable -eq 0) { # off 라면 키기
        Write-Host "${IP}:${PORT} Proxy On"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value "http://${IP}:${PORT}"
        New-BurntToastNotification -Text "ProxyOnOff",'proxy set On'
        return "proxy set On"
    }elseif ($value.ProxyEnable -eq 1) {
        Write-Host "proxy Off"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0
        New-BurntToastNotification -Text "ProxyOnOff",'proxy set Off'
        return "proxy set Off"
    }
}
proxyOnOff

