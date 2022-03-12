::init
@echo off
chcp 65001
cd %~dp0\aa
cls
echo init-OK!

::enable proxy in local machine (not needed
::set http_proxy=127.0.0.1:7890
::set https_proxy=127.0.0.1:7890

::start download files in rule-list and convert and merge
for /f "eol=# tokens=1,2 delims= " %%i in (..\rule-list.ini) do (

echo Downloading...
wget --no-hsts --no-cookies -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4937.0 Safari/537.36" --no-check-certificate -t 2 -T 30 -O down.txt %%j
echo Download-OK!

sed -i -E --posix "/^$/d" down.txt

if %%i==c2w (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^.+?,//g" down.txt
sed -i -E --posix "s/,.+$//g" down.txt
sed -i -E --posix  "s/^/@@||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==c2a (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^.+?,//g" down.txt
sed -i -E --posix "s/,.+$//g" down.txt
sed -i -E --posix  "s/^/||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2w (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
sed -i -E --posix  "s/^/@@||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2a (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
sed -i -E --posix  "s/^/||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2w (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix  "s/^/@@||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2a (
echo Auto-transformation-%%i...
sed -i -E --posix "/^\#/d" down.txt
sed -i -E --posix "/^\!/d" down.txt
sed -i -E --posix  "s/^/||/g" down.txt
sed -i -E --posix  "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==a2w (
echo Auto-transformation-%%i...
sed -i -E --posix  "s/^\|\|/@@||/g" down.txt
echo Auto-transformation-OK!
)

if %%i==w2a (
echo Auto-transformation-%%i...
sed -i -E --posix  "s/^\@\@\|\|/||/g" down.txt
echo Auto-transformation-OK!
)

echo Merging...
type blank.dd>>down.txt
type down.txt>>mergd.txt
echo Merge-OK!

)
echo Download-completed!

::Merge custom rules in folder
echo Merging-Custom...

type .\custom-rules\*>>mergd.txt

echo Merge-OK!

::primary deduplicate
echo Deduplicate...

set LC_ALL='C'
s -u -r -i -o nore.txt mergd.txt
set LC_ALL=

echo Deduplicate-OK!

::extract useful lines
echo Extracting-lines...

::extract punctuation mark into file
(sed -n -E --posix "/^\#\#/p" nore.txt)>nord.txt
(sed -n -E --posix "/^\#\%\#/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\#\$\#/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\#\@\#/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\#pkg/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\$/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\&/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\(/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\*/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\,/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\-/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\./p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\//p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\:/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\;/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\=/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\?/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\@/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\_/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\^/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\|/p" nore.txt)>>nord.txt
(sed -n -E --posix "/^\~/p" nore.txt)>>nord.txt

::extract numbers into file
(sed -n -E --posix "/^[0-9]/p" nore.txt)>>nord.txt

::extract alphabet into file
(sed -n -E --posix "/^[Aa-Zz]/p" nore.txt)>>nord.txt

echo Extract-OK!

::secondary deduplicate and sort
::(gawk "!a[$0]++" nord.txt)>nordn.txt

echo Sorting...
set LC_ALL='C'
s -u -i -o nordv.txt nord.txt
echo Sort-OK!

::count total rules
echo Counting...
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nordv.txt')do set/a rnum=1
echo Count-OK!

::get and save version code
echo Getting-codes...
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
echo Get-codes-OK!

::final merge
echo Merging...
type title.dd>w.txt
type tpdate.txt>>w.txt
type nordv.txt>>w.txt
type addition.dd>>w.txt
echo Merge-OK!

::move file out
copy /y .\w.txt ..\..\

::end cleanup
if not %rnum% gtr 100 (
echo FAILING...
exit 1
)
echo All-done!
del /f /q .\*.txt&exit
