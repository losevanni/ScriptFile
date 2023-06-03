$burpsuite="C:\Users\relos\analysis_tools\burp2022\burpsuite_pro_v2022.2.4.jar"
$loader="C:\Users\relos\analysis_tools\burp2022\burploader.jar"
function startburp {
    Start-Process `
    -FilePath "java" `
    -ArgumentList `
        "-noverify", `
        "-javaagent:${loader}", `
        "--add-opens=java.desktop/javax.swing=ALL-UNNAMED", `
        "--add-opens=java.base/java.lang=ALL-UNNAMED", `
        "-jar", `
        "${burpsuite}" `
        -WindowStyle Hidden `
}
startburp
# **잊지 말자 스크립트는 환경변수에 등록한 경로가 아니면 실행 할수없다**