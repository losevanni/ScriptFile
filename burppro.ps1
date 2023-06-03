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
