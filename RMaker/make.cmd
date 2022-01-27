::init
:: Good luck hhh

@echo off
chcp 65001
cd %~dp0\aa
set LC_ALL='C'

::start download files & encode
for /f "eol=# tokens=1,2 delims= " %%i in (..\rule-list.ini) do (wget -O i%%i.txt %%j)
for %%i in (i*.txt) do (concmd /o:utf8 %%i)

::del rubbish
if exist .\*hsts del /f /q *hsts

::del FUCKING GBK exclaimation marks
::s -r --output=x4x.txt x4.txt
::(more +3 x4x.txt)>i4.txt

::add blank line
for %%i in (i*.txt) do type blank.dd>>%%i

::Merge
type frules.dd>mergd.txt
type i*.txt>>mergd.txt

::delete repeated rules
::sort rules Random flag -R
s -u -o=nore.txt mergd.txt

::delete comments&rubbish
(findstr /v /b /c:"# " /c:"[" /c:"!" nore.txt)>nord.txt
::(gawk "!a[$0]++" nord2.txt)>nord.txt

::count rules
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nord.txt')do set/a rnum=%%a+1
::save ct
echo %rnum%>..\..\ct.txt

::add title and date
echo ! Version: %date%>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
echo ! Count: %rnum%>>tpdate.txt
echo.>>tpdate.txt
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>>tpdate.txt

type title.dd>w.txt
type tpdate.txt>>w.txt
type nord.txt>>w.txt
type brules.dd>>w.txt

copy /y .\w.txt ..\..\

::end cleanup
del /f /q .\*.txt&exit
