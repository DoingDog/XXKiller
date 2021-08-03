set file=what.txt
(FOR /F "eol=# delims=" %%i in (%file%) do (echo %%i))>%file%.tmp
(FOR /F "eol=! delims=" %%i in (%file%.tmp) do (echo %%i))>%file%
del %file%.tmp
call miz.bat
