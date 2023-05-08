param ( # 실랭시 인수로 option 과 파일경로,명 넣기
    [string]$Option,
    [string]$Path
)
Write-Host "input Option: $Option& Path: $Path"
# $OK=Read-Host "ok ? 아무키나 입력 하시오 key enter"
# 만약 옵션이 없고 인자가 한게 경로라면 down을 기본으로 하여 파일다운함
if($Path){ 
    $Path=$Option
    $Option='d' #기본값
}
if($Option -ceq 'u' -or $Option -ceq '-u'){
    #업로드
    $err=scp.exe $Path testserver_v:/home/vanni/shareFile
}elseif ($Option -ceq 'd' -or $Option -ceq '-d') {
    #다운로드
    $err=scp.exe testserver_v:/home/vanni/shareFile/$Path
}else{
    Write-Host "fail please up or down"
}
Write-Host $err

#다음버전 반복문으로 실패해도 다시 시작 하기와 여러 파일 업로드및 다운로드 하기 
# 아마 배열을 사용해서 길이 만큼 처리하고 실패한 파일 명은 따로 모아 출력 하기