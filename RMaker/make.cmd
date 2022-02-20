::init
@echo off
chcp 65001
cd %~dp0\aa
set LC_ALL='C'

::enable proxy in local machine (not needed
::set http_proxy=127.0.0.1:7890
::set https_proxy=127.0.0.1:7890

::start download files in rule-list and convert and merge
for /f "eol=# tokens=1,2 delims= " %%i in (..\rule-list.ini) do (
wget --no-hsts --no-cookies -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4860.0 Safari/537.36" --no-check-certificate -t 2 -T 30 -O down.txt %%j
type blank.dd>>down.txt

if %%i==d2w (
for /f "tokens=* delims=" %%a in (down.txt) do (
>>down1.txt echo ^@^@^|^|%%a^^
)
type down1.txt>down.txt
del /f /q down1.txt
)

if %%i==d2a (
for /f "tokens=* delims=" %%a in (down.txt) do (
>>down1.txt echo ^|^|%%a^^
)
type down1.txt>down.txt
del /f /q down1.txt
)

if %%i==a2w (
for /f "tokens=* delims=" %%a in (down.txt) do (
>>down1.txt echo ^@^@%%a^^
)
type down1.txt>down.txt
del /f /q down1.txt
)

type down.txt>>mergd.txt
)

::fix encoding to utf8 (not needed
::if error,enable this
::for %%i in (i*.txt) do (gb2u8.vbs %%i)

::delete rubbish files of wget (not needed
::if exist .\*hsts del /f /q *hsts

::add blank line to every file (not needed
::for %%i in (i*.txt) do type blank.dd>>%%i

::Merge all downloaded files (not needed
::type blank.dd>mergd.txt
::type i*.txt>>mergd.txt

::Merge custom rules in folder
type .\custom-rules\*>>mergd.txt

::primary deduplicate
s -u -r -i -o nore.txt mergd.txt

::extract useful lines

::extract punctuation mark into file
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

::extract numbers into file
(findstr /b [0-9] nore.txt)>>nord.txt

::extract alphabet into file
(findstr /b [Aa-Zz] nore.txt)>>nord.txt

::secondary deduplicate and sort
::(gawk "!a[$0]++" nord.txt)>nordn.txt
s -u -i -o nordv.txt nord.txt

::count total rules
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nordv.txt')do set/a rnum=%%a+1

::get and save version code
for /f "tokens=1,2 delims=:" %%i in ('echo %time%') do (set v3=%%i%%j)
if not %v3% gtr 999 set v3=0%v3%
for /f "tokens=2 delims= " %%i in ('echo %date%') do (set v1=%%i)
for /f "tokens=1,2,3 delims=/" %%i in ('echo %v1%') do (set v2=%%k%%i%%j)
set vs=%v2%%v3%

::get last modified time
for /f "tokens=2,3 delims= " %%i in ('echo %date%T%time%Z') do (set lm=%%i%%j)

::save info into file
echo version : %vs%>..\..\ct.txt
echo count : %rnum%>>..\..\ct.txt

::add title and date to rule
echo ! Version: %vs%>tpdate.txt
echo ! Last modified: %lm% UTC>>tpdate.txt
echo ! Count: %rnum%>>tpdate.txt
echo.>>tpdate.txt
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>>tpdate.txt
echo.>>tpdate.txt

::final merge
type title.dd>w.txt
type tpdate.txt>>w.txt
type nordv.txt>>w.txt
type addition.dd>>w.txt

::move file out
copy /y .\w.txt ..\..\

::end cleanup
del /f /q .\*.txt&exit
