$ico_path = ".\.github\scripts\win-data\game.ico"

$project_dir = ((Get-Item .)[0].ToString() | Resolve-Path).ToString()
$data_path = Join-Path -Path $project_dir -ChildPath ".build"
$output_path = Join-Path -Path $data_path -ChildPath "game-x64"

Remove-Item -Path $output_path -Force -Recurse -ErrorAction SilentlyContinue

Write-Host "Create game.love"
.\.github\scripts\create_love.ps1

Write-Host "Loading rcedit..."
$rcedit_url=((Invoke-WebRequest -URI 'https://api.github.com/repos/electron/rcedit/releases/latest' | ConvertFrom-Json).assets | Where-Object { $_.name -eq "rcedit-x64.exe" }).browser_download_url
Write-Host "rcedit url: $($rcedit_url)"
Invoke-WebRequest -Uri $rcedit_url -OutFile "./rcedit.exe"

Write-Host "Loading love..."
$love_url=((Invoke-WebRequest -URI 'https://api.github.com/repos/love2d/love/releases/latest' | ConvertFrom-Json).assets | Where-Object { $_.name -like "love-*-win64.zip" }).browser_download_url
Write-Host "love url: $($love_url)"
Invoke-WebRequest -Uri $love_url -OutFile "./love2d-x64.zip"
Expand-Archive -LiteralPath "./love2d-x64.zip" -DestinationPath "."
Move-Item -Path (Get-Item "./love-*-win*/").ToString() -Destination $output_path

Write-Host "Setting icon..."
&"./rcedit.exe" (Join-Path -Path $output_path -ChildPath "love.exe") --set-icon $ico_path

Write-Host "Creating binary..."
Copy-Item -Path (Join-Path -Path $data_path -ChildPath "game.love") -Destination (Join-Path -Path $output_path -ChildPath "game.love")
cd $output_path
cmd /c copy /b "love.exe+game.love" "game.exe"

Write-Host "Cleaning up..."
Get-ChildItem -Path . -Exclude "*.dll", "license.txt", "game.exe" | Remove-Item -Force
cd $project_dir
Remove-Item -LiteralPath "./love2d-x64.zip" -Force
Remove-Item -LiteralPath "./rcedit.exe" -Force
