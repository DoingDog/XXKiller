@echo off
set file=what.txt
(FOR /F "eol=# delims=" %%i in (%file%) do (echo %%i))>%file%.tmp
type %file%.tmp>%file%
del %file%.tmp
(FOR /F "eol=! delims=" %%i in (%file%) do (echo %%i))>%file%.tmp
type %file%.tmp>%file%
del %file%.tmp
call miz.bat