@echo off
setlocal enabledelayedexpansion

::config

set EXTENSION_VIDEO=.mp4
set OUTPUT_VIDEO=output.mp4

::code
del /f run.cmd
ECHO | set /p=ffmpeg  >> run.cmd

for %%f in (*.mp4) do ( 
ECHO | set /p= -i %%f >> run.cmd 
ECHO %%f Added in the queue
)

ECHO|set /p=-filter_complex >> run.cmd
ECHO|set /p=^^""" >> run.cmd

set /a COUNTER=0
for %%f in (*.mp4) do ( 
(ECHO|set /p=[!COUNTER!:v:0][!COUNTER!:a:0])>>run.cmd 
set /a COUNTER+=1
)

(ECHO|set /p = concat=n=%COUNTER%:v=1:a=1[outv][outa])>> run.cmd
ECHO|set /p=^^"" " >> run.cmd

ECHO|set /p= -map "[outv]" -map "[outa]" %OUTPUT_VIDEO% >> run.cmd

ECHO Batch merging script done, running
::timeout 1 > NUL
call run.cmd

::timeout 3 > NUL
del run.cmd
ECHO Merging Complete. Press any key plus Enter to exit. 

pause
