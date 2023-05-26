# $lastPath=$PWD.Path.Substring(($PWD.Path.LastIndexOf("\")+1))
# Write-Host "Open explorer $lastPath" -ForegroundColor Blue
Start-Process explorer -ArgumentList $PWD.Path



