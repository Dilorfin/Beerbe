Write-Host "Create game.love"
.\.github\scripts\create_love.ps1

Write-Host "Copy game.love to android project"
Copy-Item ".\.build\game.love" -Destination ".\love-android\app\src\main\assets\game.love" -Force

cd ./love-android
Write-Host "Applying patch"
git apply "..\.github\scripts\apk-patches\android.patch"
Write-Host "Unpacking icons"
Expand-Archive -Path "..\.github\scripts\apk-patches\drawable.zip" -DestinationPath ".\app\src\main\res\" -Force
Write-Host "Start build script"
./gradlew assembleNormal
cd ..