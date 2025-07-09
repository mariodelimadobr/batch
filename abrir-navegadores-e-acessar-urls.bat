@echo off
REM Script .BAT para abrir URLs em navegadores Chrome e Edge

REM === Defina as URLs ===
set URL_CHROME=https://www.google.com
set URL_EDGE=https://www.microsoft.com

REM === Caminho padrão do Chrome e Edge no Windows 10/11 ===
set CHROME_PATH="C:\Program Files\Google\Chrome\Application\chrome.exe"
set EDGE_PATH="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

REM === Abrir URL no Chrome ===
if exist %CHROME_PATH% (
    start "" %CHROME_PATH% %URL_CHROME%
) else (
    echo Chrome não encontrado em %CHROME_PATH%
)

REM === Abrir URL no Edge ===
if exist %EDGE_PATH% (
    start "" %EDGE_PATH% %URL_EDGE%
) else (
    echo Edge não encontrado em %EDGE_PATH%
)

exit /b
