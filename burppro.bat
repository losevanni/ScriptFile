@echo off
setlocal
@REM loader 와 burpsuite 자리에는 각각 burp pro 2022 폴더안에  burploader.jar 와 burpsuite_pro_v2022.2.4.jar 경로가 있어야 한다
set "java_path=java"
@REM ex: "loader=C:\Users\userName\burpPro2022\buprloader.jar"
set "loader=burploader.jar" 
set "burpsuite=burpsuite_pro_v2022.2.4.jar"

%java_path% -noverify -javaagent:%loader% --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -jar %burpsuite% >NUL 2>&1

endlocal
