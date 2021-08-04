::TheRuleMaker
::Merge
type prus.dd>mergd.txt
type i*.txt>>mergd.txt
del /f /q i*.txt
::nore
ren awk.bat gawk.exe
gawk "!a[$0]++" mergd.txt>nore.txt
ren gawk.exe awk.bat
del /f /q mergd.txt
::del comments
(FOR /F "eol=# delims=" %%i in (nore.txt) do (echo %%i))>ktmp.txt
(FOR /F "eol=! delims=" %%i in (ktmp.txt) do (echo %%i))>nore.txt
del /f /q ktmp.txt
::add title and date
copy title.dd+what.txt+blk.dd w.txt
echo ! Version: %date%>>tempdate.txt
echo ! Last modified: %date%T%time%Z>>tempdate.txt
copy tempdate.txt+w.txt ..\..\w.txt
::end
del /f /q *.txt&exit
