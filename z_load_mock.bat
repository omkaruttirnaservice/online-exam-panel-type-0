@echo off
:: Ask for MySQL username
set /p mysql_user=Enter MySQL username: 

:: Ask for MySQL password
set /p mysql_password=Enter MySQL password: 





:: Confirm whether to start the import
set /p confirm=Do you want to import the MySQL database? (y/n): 

:: Ask for dump file path
set dump_file_path=C:\exam\nginx\html\exam\bin\mock.xyz

:: Ask for MySQL database name
set database_name=utr_node_exam 

:: If the user enters 'y', proceed with the import
if /i "%confirm%"=="y" (
    echo Starting MySQL import...

    :: Check if the dump file exists
    if not exist "%dump_file_path%" (
        echo The dump file was not found at the specified path: %dump_file_path%
        pause
        exit /b
    )

    :: Run the MySQL import command
    mysql -u %mysql_user% -p%mysql_password% %database_name% < "%dump_file_path%"

    :: Check if the import was successful
    if %errorlevel%==0 (
        echo Database import completed successfully.
    ) else (
        echo Database import failed. Please check your MySQL configuration.
    )
    
) else (
    echo Import canceled by the user.
)

pause