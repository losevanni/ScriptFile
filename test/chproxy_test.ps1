param (
    [string]$IP,
    [string]$PORT
)
#입력값이 없으면 기본값으로 설정 
if(!$IP){
    $IP='127.0.0.1'
}
if(!$PORT){
    $PORT='8888'
}

function proxyOnOff { # 꺼저있으면 키고 켜저있으면 끈다 동시에 결과를 알림창에 표시 
    $value=Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyEnable
    if ($value.ProxyEnable -eq 0) { # off 라면 키기
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value "http://${IP}:${PORT}"
        
        New-BurntToastNotification -Text "ProxyOnOff",'proxy set On'
        return "proxy set On"
    }elseif ($value.ProxyEnable -eq 1) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 0
        New-BurntToastNotification -Text "ProxyOnOff",'proxy set Off'
        return "proxy set Off"
    }
}
# 입력 값이 존재한다면 입력 값 포트 로 실행 한다 단 입력 값을 검증 하자
#ip 만있을때 port 만 있을때 설정 따로따로

proxyOnOff


