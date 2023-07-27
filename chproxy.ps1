
param ( # 실행시 인수로 option 과 파일경로,명 넣기
    [string]$Option
)
function proxyOnOff {
    $value=Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyEnable
    if ($value.ProxyEnable -eq 0) { # off 라면 키기
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 1
        $ret=Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyServer
        Write-Host "$ret Proxy On"
        New-BurntToastNotification -Text "ProxyOnOff",'proxy set On'
        return "proxy set On"
    }elseif ($value.ProxyEnable -eq 1) {
        Write-Host "proxy Off"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0
        New-BurntToastNotification -Text "ProxyOnOff",'proxy set Off'
        return "proxy set Off"
    }
}
function setvalue{
    if($Option){
        # ip 를 물어보는 로직 추가
        Write-Host "IP 를 입력 하세요"
        $IP=Read-Host
        if(!$IP){
            $IP='127.0.0.1'
        }
        Write-Host "PORT 번호를 입력 하세요"
        $PORT=Read-Host
        if(!$PORT){
            $PORT='8888'
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value "${IP}:${PORT}"
        Write-Host "${IP}:${PORT} 설정"
    }
}
function catset {
    $SETINFO=Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" | Select-Object ProxyEnable
    $IPPORTINFO=Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" | Select-Object ProxyServer
    Write-Host "$SETINFO $IPPORTINFO 설정"
}

if(!$Option){ # null 이면 on off
    proxyOnOff
}elseif($Option -eq 'i'){ # 설정 보여주기
    catset
}else{ # ip port 설정
    setvalue
}
    
