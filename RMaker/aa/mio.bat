type prus.bat>mgd.txt
type i*.txt>>mgd.txt
del /f /q i*.txt
ren awk.bat gawk.exe
gawk "!a[$0]++" mgd.txt>what.txt
ren gawk.exe awk.bat
del /f /q mgd.txt
set file=what.txt
(FOR /F "eol=# delims=" %%i in (%file%) do (echo %%i))>seth.txt
(FOR /F "eol=! delims=" %%i in (seth.txt) do (echo %%i))>%file%
del /f /q seth.txt
copy mib.bat+what.txt+mis.bat w.txt
del /f /q what.txt
call add.bat
echo ! Version: %date%>>tempdate.txt
echo ! Last modified: %date%T%time%Z>>tempdate.txt
copy tempdate.txt+w.txt ..\..\w.txt
del /f /q *.txt
exit
