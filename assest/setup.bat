@echo off
SETLOCAL ENABLEEXTENSIONS

:: Check for existing Python installation and uninstall
echo Checking for existing Python installation...
WHERE python >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Python installation found, attempting to uninstall...
    python -m pip uninstall -y python
) ELSE (
    echo No Python installation found.
)

:: Download and install Python
echo Downloading Python 3.12.3...
powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe' -OutFile 'python-3.12.3-amd64.exe'"
echo Installing Python 3.12.3...
start /wait python-3.12.3-amd64.exe /quiet InstallAllUsers=1 PrependPath=1

:: Download and unzip the tool repository
echo Downloading tool repository...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/kdo2064/Dx-Raptor/archive/refs/heads/main.zip' -OutFile 'Dx-Raptor-main.zip'"
IF %ERRORLEVEL% EQU 0 (
    echo Unzipping tool repository...
    powershell -Command "Expand-Archive -LiteralPath 'Dx-Raptor-main.zip' -DestinationPath '%~dp0'"
    echo Tool has been downloaded and unzipped successfully.
) ELSE (
    echo Error downloading the tool. Please check your internet connection and try again.
)

echo Setup completed.
ENDLOCAL
