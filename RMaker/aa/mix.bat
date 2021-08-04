set file=what.txt
(FOR /F "eol=# delims=" %%i in (%file%) do (echo %%i))>seth.txt
(FOR /F "eol=! delims=" %%i in (seth.txt) do (echo %%i))>%file%
del /f /q seth.txt
call miz.bat
