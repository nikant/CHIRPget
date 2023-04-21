@echo off
rem by nikant
setlocal enabledelayedexpansion

set /a day=-1

:loop
set today=%date:~-4%%date:~3,2%%date:~0,2%
echo.
set /a day=%day%+1
set /a testdate=%today%-%day%
echo !testdate!
echo.
set url=https://trac.chirp.danplanet.com/chirp_next/next-%testdate%/chirp-next-%testdate%-win32.zip
echo !url!
echo.
echo.
start /wait wget.exe -q --spider !url!
if errorlevel 8 (
    if %day% lss 30 (
        goto :loop
    ) else (
        echo File not found for today or the previous 30 days.
        exit /b 1
    )
) else (
    if exist chirp-next-%testdate%-win32.zip (
       rem file exists
    ) else (
       start /wait wget.exe !url! -O chirp-next-%testdate%-win32.zip
    )
    start /wait 7z32x.exe x chirp-next-%testdate%-win32.zip -ochirp-next-%testdate%-win32 -y
    del chirp-next-%testdate%-win32.zip
)
echo 
echo 
echo.
timeout /t 10
