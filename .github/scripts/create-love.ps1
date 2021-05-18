Write-Host "Remove already existig game.love"
Remove-Item -Path ".\.build\game.love" -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path ".\.build\" | Out-Null

Write-Host "Create game.zip"
Get-ChildItem -Path "." -Exclude ".*", "love-android" | Compress-Archive -Update -DestinationPath ((Resolve-Path -Path ".\.build\").Path + "game.zip")

Write-Host "Renaming game.zip to games.love"
Get-ChildItem ".\.build\game.zip" | Rename-Item -Force -NewName "game.love"