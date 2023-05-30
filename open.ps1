# $lastPath=$PWD.Path.Substring(($PWD.Path.LastIndexOf("\")+1))
# Write-Host "Open explorer $lastPath" -ForegroundColor Blue
# Start-Process explorer -ArgumentList $PWD.Path
param (
    [string]$path
)
if($path){
    Write-Host "${path}"
}else {
    $path = '.'
}
Start-Process explorer -ArgumentList $path



