@echo off
setlocal EnableDelayedExpansion

:: Define the maximum size for each chunk (2 MB)
set maxSize=2097152

:: Create the upload directory if it doesn't exist
if not exist upload (
    mkdir upload
)

:: Iterate over each .csv file in the current directory
for %%F in (*.csv) do (
    :: Get the size of the current file
    set fileSize=%%~zF

    :: Check if the file size is greater than the maximum size
    if !fileSize! GTR %maxSize% (
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

                :: Check the size of the current chunk file
                for %%A in ("upload\%%~nF_!chunk!.csv") do set chunkSize=%%~zA
                if !chunkSize! GEQ %maxSize% (
                    :: Reset the line counter and increment the chunk counter
                    set /a lineCount=0
                    set /a chunk+=1
                )
            )
        )
    ) else (
        :: If the file size is less than or equal to the maximum size, just copy it to the upload folder
        copy "%%F" "upload\%%~nxF"
    )
)

echo CSV files have been processed.
pause
