Write-Host "Create game.love"
.\.github\scripts\create-love.ps1

Write-Host "Copy game.love to android project"
Copy-Item ".\.build\game.love" -Destination ".\love-android\app\src\main\assets\game.love" -Force

cd ./love-android
Write-Host "Applying patch"
git apply "..\.github\scripts\apk-data\android.patch"

Write-Host "Unpacking icons"
Expand-Archive -Path "..\.github\scripts\apk-data\drawable.zip" -DestinationPath ".\app\src\main\res\" -Force

Write-Host "Start build script"
./gradlew assembleNormal
cd ..