::init
@echo off
chcp 65001
cd %~dp0\aa
set LC_ALL='C'

::start download files
for /f "eol=# tokens=1,2 delims= " %%i in (..\rule-list.ini) do (wget -O i%%i.txt %%j)

::fix encode
for %%i in (i*.txt) do (gb2u8.vbs %%i)

::delete rubbish files
if exist .\*hsts del /f /q *hsts

::add blank line to every file
for %%i in (i*.txt) do type blank.dd>>%%i

::Merge all downloaded files
type blank.dd>mergd.txt
type i*.txt>>mergd.txt

::Merge custom rules
type .\custom-rules\*>>mergd.txt

::primary deduplicate
s -u -r -i -o nore.txt mergd.txt

::extract useful lines

::punctuation mark
(findstr /b /c:"##" nore.txt)>nord.txt
(findstr /b /c:"#%#" nore.txt)>>nord.txt
(findstr /b /c:"#$#" nore.txt)>>nord.txt
(findstr /b /c:"#@#" nore.txt)>>nord.txt
(findstr /b /c:"#pkg" nore.txt)>>nord.txt
(findstr /b /c:"$" nore.txt)>>nord.txt
(findstr /b /c:"&" nore.txt)>>nord.txt
(findstr /b /c:"(" nore.txt)>>nord.txt
(findstr /b /c:"*" nore.txt)>>nord.txt
(findstr /b /c:"," nore.txt)>>nord.txt
(findstr /b /c:"-" nore.txt)>>nord.txt
(findstr /b /c:"." nore.txt)>>nord.txt
(findstr /b /c:"/" nore.txt)>>nord.txt
(findstr /b /c:":" nore.txt)>>nord.txt
(findstr /b /c:";" nore.txt)>>nord.txt
(findstr /b /c:"=" nore.txt)>>nord.txt
(findstr /b /c:"?" nore.txt)>>nord.txt
(findstr /b /c:"@" nore.txt)>>nord.txt
(findstr /b /c:"_" nore.txt)>>nord.txt
(findstr /b /c:"^" nore.txt)>>nord.txt
(findstr /b /c:"|" nore.txt)>>nord.txt
(findstr /b /c:"~" nore.txt)>>nord.txt

::numbers
(findstr /b /c:"0" nore.txt)>>nord.txt
(findstr /b /c:"1" nore.txt)>>nord.txt
(findstr /b /c:"2" nore.txt)>>nord.txt
(findstr /b /c:"3" nore.txt)>>nord.txt
(findstr /b /c:"4" nore.txt)>>nord.txt
(findstr /b /c:"5" nore.txt)>>nord.txt
(findstr /b /c:"6" nore.txt)>>nord.txt
(findstr /b /c:"7" nore.txt)>>nord.txt
(findstr /b /c:"8" nore.txt)>>nord.txt
(findstr /b /c:"9" nore.txt)>>nord.txt

::lower case
(findstr /b /c:"q" nore.txt)>>nord.txt
(findstr /b /c:"w" nore.txt)>>nord.txt
(findstr /b /c:"e" nore.txt)>>nord.txt
(findstr /b /c:"r" nore.txt)>>nord.txt
(findstr /b /c:"t" nore.txt)>>nord.txt
(findstr /b /c:"y" nore.txt)>>nord.txt
(findstr /b /c:"u" nore.txt)>>nord.txt
(findstr /b /c:"i" nore.txt)>>nord.txt
(findstr /b /c:"o" nore.txt)>>nord.txt
(findstr /b /c:"p" nore.txt)>>nord.txt
(findstr /b /c:"a" nore.txt)>>nord.txt
(findstr /b /c:"s" nore.txt)>>nord.txt
(findstr /b /c:"d" nore.txt)>>nord.txt
(findstr /b /c:"f" nore.txt)>>nord.txt
(findstr /b /c:"g" nore.txt)>>nord.txt
(findstr /b /c:"h" nore.txt)>>nord.txt
(findstr /b /c:"j" nore.txt)>>nord.txt
(findstr /b /c:"k" nore.txt)>>nord.txt
(findstr /b /c:"l" nore.txt)>>nord.txt
(findstr /b /c:"z" nore.txt)>>nord.txt
(findstr /b /c:"x" nore.txt)>>nord.txt
(findstr /b /c:"c" nore.txt)>>nord.txt
(findstr /b /c:"v" nore.txt)>>nord.txt
(findstr /b /c:"b" nore.txt)>>nord.txt
(findstr /b /c:"n" nore.txt)>>nord.txt
(findstr /b /c:"m" nore.txt)>>nord.txt

::upper case
(findstr /b /c:"Q" nore.txt)>>nord.txt
(findstr /b /c:"W" nore.txt)>>nord.txt
(findstr /b /c:"E" nore.txt)>>nord.txt
(findstr /b /c:"R" nore.txt)>>nord.txt
(findstr /b /c:"T" nore.txt)>>nord.txt
(findstr /b /c:"Y" nore.txt)>>nord.txt
(findstr /b /c:"U" nore.txt)>>nord.txt
(findstr /b /c:"I" nore.txt)>>nord.txt
(findstr /b /c:"O" nore.txt)>>nord.txt
(findstr /b /c:"P" nore.txt)>>nord.txt
(findstr /b /c:"A" nore.txt)>>nord.txt
(findstr /b /c:"S" nore.txt)>>nord.txt
(findstr /b /c:"D" nore.txt)>>nord.txt
(findstr /b /c:"F" nore.txt)>>nord.txt
(findstr /b /c:"G" nore.txt)>>nord.txt
(findstr /b /c:"H" nore.txt)>>nord.txt
(findstr /b /c:"J" nore.txt)>>nord.txt
(findstr /b /c:"K" nore.txt)>>nord.txt
(findstr /b /c:"L" nore.txt)>>nord.txt
(findstr /b /c:"Z" nore.txt)>>nord.txt
(findstr /b /c:"X" nore.txt)>>nord.txt
(findstr /b /c:"C" nore.txt)>>nord.txt
(findstr /b /c:"V" nore.txt)>>nord.txt
(findstr /b /c:"B" nore.txt)>>nord.txt
(findstr /b /c:"N" nore.txt)>>nord.txt
(findstr /b /c:"M" nore.txt)>>nord.txt

::secondary deduplicate
(gawk "!a[$0]++" nord.txt)>nordv.txt

::count rules
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nordv.txt')do set/a rnum=%%a+1

::save number
echo %rnum%>..\..\ct.txt

::add title and date
echo ! Version: %date%>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
echo ! Count: %rnum%>>tpdate.txt
echo.>>tpdate.txt
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>>tpdate.txt
echo.>>tpdate.txt

::final merge
type title.dd>w.txt
type tpdate.txt>>w.txt
type nordv.txt>>w.txt
type addition.dd>>w.txt

::move file
copy /y .\w.txt ..\..\

::end cleanup
del /f /q .\*.txt&exit
