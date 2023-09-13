
param ( # 실행시 인수로 option 과 파일경로,명 넣기
    [string]$Option
)
$NETPATH='HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
function proxyOnOff {
    $value=Get-ItemProperty -Path $NETPATH | Select-Object ProxyEnable
    if ($value.ProxyEnable -eq 0) { # off 라면 키기
        Set-ItemProperty -Path $NETPATH -Name ProxyEnable -Value 1
        $ret=Get-ItemProperty -Path $NETPATH | Select-Object ProxyServer
        $ret=$ret[0].ProxyServer
        Write-Host "Proxy ON"$ret
        New-BurntToastNotification -Text "ProxyON","$ret"
        return "proxy set ON"
    }elseif ($value.ProxyEnable -eq 1) {
        Write-Host "proxy OFF"
        Set-ItemProperty -Path $NETPATH -Name ProxyEnable -Value 0
        New-BurntToastNotification -Text "ProxyOFF",'OFF'
        return "proxy set OFF"
    }
}
function setvalue{
    if($Option){
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
        Set-ItemProperty -Path $NETPATH -Name ProxyServer -Value "${IP}:${PORT}"
        New-BurntToastNotification -Text "Proxy Set IP, PORT",${IP}':'${PORT}' 설정 완료'
        Write-Host "${IP}:${PORT} 설정"
    }
}
function catinfo {
    $SETINFO=Get-ItemProperty -Path $NETPATH | Select-Object ProxyEnable
    $IPPORTINFO=Get-ItemProperty -Path $NETPATH | Select-Object ProxyServer
    $Over=Get-ItemProperty -Path $NETPATH | Select-Object ProxyOverride
    if($SETINFO[0].ProxyServer -eq 1){
        Write-Host "Proxy SET: ON"
    }else{
        Write-Host "Proxy SET: OFF"
    }
    Write-Host "IP PORT :"$IPPORTINFO[0].ProxyServer
    # Override 도 표시 이것 때문에 안잡힌 적이 있음
    if($Over[0].ProxyOverride){ 
        Write-Host "ProxyOverride :"$Over 
    }
}

if(!$Option){ # null 이면 on off
    proxyOnOff
}elseif($Option -ceq 'i' -or $Option -ceq '-i'){ # 설정 보여주기
    catinfo
}else{ # i 외에 옵션은 전부 ip port 설정
    setvalue
}

# next catset -> info 이름 변경 , 번트토스트에 ip port 번호 나올수있게 수정 하기
    
