@echo off
rem Build the Expo web app (the WYRD gate/mind UI, in the separate mobile project) into this server's web\app.
rem Works on either computer: set WYRD_MOBILE_DIR to the mobile folder, or it is found at
rem C:\Users\TEN\consciousness-bot\mobile, or beside this repo as ..\wyrd\mobile or ..\consciousness-bot\mobile.
setlocal
set "SERVER=%~dp0.."
set "MOBILE=%WYRD_MOBILE_DIR%"
if not defined MOBILE if exist "C:\Users\TEN\consciousness-bot\mobile\app.json" set "MOBILE=C:\Users\TEN\consciousness-bot\mobile"
if not defined MOBILE if exist "%SERVER%\..\..\wyrd\mobile\app.json" set "MOBILE=%SERVER%\..\..\wyrd\mobile"
if not defined MOBILE if exist "%SERVER%\..\..\consciousness-bot\mobile\app.json" set "MOBILE=%SERVER%\..\..\consciousness-bot\mobile"
if not defined MOBILE (
  echo Could not find the WYRD mobile project. Set WYRD_MOBILE_DIR to its folder.
  exit /b 1
)
echo Building the web app from %MOBILE%
cd /D "%MOBILE%" || exit /b 1
if not exist node_modules (call npm ci || exit /b 1)
set "EXPO_PUBLIC_WYRD_SERVERPOD_URL=https://wryd00.api.serverpod.space"
call npx expo export --platform web || exit /b 1
if exist "%SERVER%\web\app" rmdir /S /Q "%SERVER%\web\app"
xcopy /E /I /Y /Q dist "%SERVER%\web\app" || exit /b 1
echo Web app ready in %SERVER%\web\app
