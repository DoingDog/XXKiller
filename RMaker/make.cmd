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
(findstr /b [0-9] nore.txt)>>nord.txt

::alphabet
(findstr /b [Aa-Zz] nore.txt)>>nord.txt

::secondary deduplicate and sort
(gawk "!a[$0]++" nord.txt)>nordn.txt
s -i -o nordv.txt nordn.txt

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
