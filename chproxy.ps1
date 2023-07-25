
param ( # 실행시 인수로 option 과 파일경로,명 넣기
    [string]$Option
)
function proxyOnOff {
    $IP='127.0.0.1'
    $PORT='8888'
    $value=Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyEnable
    if ($value.ProxyEnable -eq 0) { # off 라면 키기
        if($Option){
            # ip 를 물어보는 로직 추가
            Write-Host "IP 를 입력 하세요"
            $IP=Read-Host
            Write-Host "PORT 번호를 입력 하세요"
            $PORT=Read-Host
            if(!$PORT){
                $PORT='8888'
            }
        }
        Write-Host "${IP}:${PORT} Proxy On"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value "${IP}:${PORT}"
        New-BurntToastNotification -Text "ProxyOnOff",'proxy set On'
        return "proxy set On"
    }elseif ($value.ProxyEnable -eq 1) {
        Write-Host "proxy Off"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0
        New-BurntToastNotification -Text "ProxyOnOff",'proxy set Off'
        return "proxy set Off"
    }
}
if($Option -eq 'i'){
    $SETINFO=Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" | Select-Object ProxyEnable
    $IPPORTINFO=Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" | Select-Object ProxyServer
    Write-Host "$SETINFO $IPPORTINFO 설정"
}else{
    proxyOnOff
}

