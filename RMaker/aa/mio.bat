::TheRuleMaker
::No need to change

::Merge
type ftrule.dd>mergd.txt
type i*.txt>>mergd.txt

::nore
gawk "!a[$0]++" mergd.txt>nore.txt

::del comments
(FOR /F "eol=# delims=" %%i in (nore.txt) do (echo %%i))>ktmp.txt
(FOR /F "eol=! delims=" %%i in (ktmp.txt) do (echo %%i))>nord.txt

::add title and date
echo ! Version: %date%>>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
copy title.dd+tpdate.txt+nord.txt+bkrule.dd final.txt

::end
copy /y final.txt ..\..\
del /f /q *.txt&exit
