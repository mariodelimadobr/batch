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
        :: Initialize chunk counter and byte counter
        set /a chunk=0
        set /a byteCount=0

        :: Read the file line by line
        for /F "usebackq delims=" %%L in ("%%F") do (
            :: Check if the byte count exceeds the maximum size
            if !byteCount! GEQ %maxSize% (
                :: Reset the byte counter and increment the chunk counter
                set /a byteCount=0
                set /a chunk+=1
            )

            :: Append the line to the current chunk file
            echo %%L>> upload\%%~nF_!chunk!.csv

            :: Update the byte count
            set /a byteCount+=1
        )
    ) else (
        :: If the file size is less than or equal to the maximum size, just copy it to the upload folder
        copy "%%F" "upload\%%~nxF"
    )
)

echo CSV files have been processed.
pause
