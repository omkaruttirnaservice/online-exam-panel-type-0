@echo off 

set /p answer=Do you want to stop a server? (Y/N): 
if /i "%answer:~0,1%"=="Y" (
    echo Stoping process...
    pm2 delete 0
    echo Server stop.
    pause
    ) else (
    echo Process cancelled. 
)