::TheRuleMaker

::Merge
type prus.dd>mergd.txt
type i*.txt>>mergd.txt

::nore
ren awk.bat gawk.exe
gawk "!a[$0]++" mergd.txt>nore.txt
ren gawk.exe awk.bat

::del comments
(FOR /F "eol=# delims=" %%i in (nore.txt) do (echo %%i))>ktmp.txt
(FOR /F "eol=! delims=" %%i in (ktmp.txt) do (echo %%i))>nord.txt

::add title and date
echo ! Version: %date%>>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
copy title.dd+tpdate.txt+nord.txt ..\..\w.txt

::end
del /f /q *.txt&exit
