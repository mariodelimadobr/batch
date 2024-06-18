@echo off
setlocal EnableDelayedExpansion

:: Define the maximum number of lines for each chunk
set maxLines=3500

:: Create the upload directory if it doesn't exist
if not exist upload (
    mkdir upload
)

:: Iterate over each .csv file in the current directory
for %%F in (*.csv) do (
    :: Get the size of the current file
    set fileSize=%%~zF

    :: Initialize chunk counter and line counter
    set /a chunk=0
    set /a lineCount=0
    set "header="
    
    :: Read the file line by line
    for /F "usebackq tokens=*" %%L in ("%%F") do (
        if "!lineCount!" == "0" (
            set "header=%%L"
            echo !header! > "upload\%%~nF_!chunk!.csv"
            set /a lineCount+=1
        ) else (
            :: Append the line to the current chunk file
            echo %%L>> "upload\%%~nF_!chunk!.csv"
            set /a lineCount+=1

            :: Check if the number of lines in the current chunk file has reached the maximum
            if !lineCount! GEQ %maxLines% (
                :: Reset the line counter and increment the chunk counter
                set /a lineCount=0
                set /a chunk+=1
            )
        )
    )
)

echo CSV files have been processed.
pause
