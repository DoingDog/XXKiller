::init
@echo off
set MAINFOLD=%1
if not defined MAINFOLD goto :eof
if not exist %~dp0\%MAINFOLD% goto :eof
cd /d %~dp0\%MAINFOLD%
chcp 65001
cls
if exist ..\%MAINFOLD%.txt del /f /q ..\%MAINFOLD%.txt
if exist .\*.txt del /f /q .\*.txt
if exist *.txt del /f /q *.txt
tzutil /s "China Standard Time"
set wgetFix=-nv --no-config -t 3 --no-netrc -T 30 --connect-timeout=10 --read-timeout=10 -w 1 -4 --no-iri --no-cache -U "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1 SearchCraft/3.9.0 (Baidu; P2 16.0)" --no-cookies --https-only --no-hsts --local-encoding=UTF-8 --remote-encoding=UTF-8 --restrict-file-names=nocontrol
set curlFix=-L -q --connect-timeout 10 -k -4 -m 30 -e "https://google.com/" -s -S -A "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1 SearchCraft/3.9.0 (Baidu; P2 16.0)"
echo Init-OK-in-%MAINFOLD%!

::enable proxy in China local machine (not needed)
set isproxy=0
set httproxy=172.16.0.2:8899

if %isproxy%==1 set curlproxy= -x %httproxy%
if %isproxy%==1 set http_proxy=%httproxy%
if %isproxy%==1 set https_proxy=%httproxy%

::get binaries
curl %curlFix%%curlproxy% --url https://raw.githubusercontent.com/DoingDog/DoingDog/main/wget.exe -o wget.exe
curl %curlFix%%curlproxy% --url https://raw.githubusercontent.com/DoingDog/DoingDog/main/busybox.exe -o busybox.exe
curl %curlFix%%curlproxy% --url https://raw.githubusercontent.com/DoingDog/DoingDog/main/FOP.py -o FOP.py
if not exist .\wget.exe (
del /f /q *.exe>nul 2>nul
del /f /q *.py>nul 2>nul
goto :eof
)
if not exist .\busybox.exe (
del /f /q *.exe>nul 2>nul
del /f /q *.py>nul 2>nul
goto :eof
)
if not exist .\FOP.py (
del /f /q *.exe>nul 2>nul
del /f /q *.py>nul 2>nul
goto :eof
)
echo get-binaries-OK!

::process list
for /f "eol=# tokens=1 delims= " %%i in (rule-list.ini) do (
>>list.txt echo %%i
)

::start download files in rule-list and convert and merge
for /f "skip=1 eol=; tokens=1,2,3 delims==" %%i in (list.txt) do (

if not %%i==loc echo Downloading...
if not %%i==loc wget %wgetFix% -O down.txt %%j
if not %%i==loc echo Download-OK!

if %%i==loc copy /y %%j down.txt
if %%i==loc echo copy Local %%j...

if exist down.txt echo File successfully get
if not exist down.txt echo Warn NO FILE

busybox sed -i -E "/^$/d" down.txt

if %%i==c2w (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^.+?,//g" down.txt
busybox sed -i -E "s/,.+$//g" down.txt
busybox sed -i -E "s/^/@@||/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==c2a (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^.+?,//g" down.txt
busybox sed -i -E "s/,.+$//g" down.txt
busybox sed -i -E "s/^/||/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2w (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
busybox sed -i -E "s/^/@@||/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2a (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
busybox sed -i -E "s/^/||/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2w (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^/@@||/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2a (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^/||/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2wa (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
busybox sed -i -E "s/^/@@|/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==h2aa (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ +//g" down.txt
busybox sed -i -E "s/^/|/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2wa (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^/@@|/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==d2aa (
echo Auto-transformation-%%i...
busybox sed -i -E "/^\#/d" down.txt
busybox sed -i -E "/^\!/d" down.txt
busybox sed -i -E "s/^/|/g" down.txt
busybox sed -i -E "s/$/^/g" down.txt
echo Auto-transformation-OK!
)

if %%i==a2w (
echo Auto-transformation-%%i...
busybox sed -i -E "s/^\|\|/@@||/g" down.txt
echo Auto-transformation-OK!
)

if %%i==w2a (
echo Auto-transformation-%%i...
busybox sed -i -E "s/^\@\@\|\|/||/g" down.txt
echo Auto-transformation-OK!
)

echo Merging...
echo.>>down.txt
type down.txt>>mergd.txt
echo Merge-OK!

)
echo Download-completed!

::Merge custom rules in folder
if exist custom-rules echo Merging-Custom...
if exist custom-rules type .\custom-rules\*>>mergd.txt
if exist custom-rules echo Merge-OK!

::primary deduplicate
echo Deduplicate...

set LC_ALL='C'
busybox sort -u -r -i -o nore.txt mergd.txt
set LC_ALL=

echo Deduplicate-OK!

::extract useful lines
echo Extracting-lines...

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

echo Extract-OK!

echo Removing...

::remove too short lines
busybox sed -i -E "/^$/d" nord.txt
busybox sed -i -E "/^.$/d" nord.txt
busybox sed -i -E "/^..$/d" nord.txt
busybox sed -i -E "/^...$/d" nord.txt
busybox sed -i -E "/^....$/d" nord.txt
busybox sed -i -E "/^.....$/d" nord.txt

::remove custom
for /f "tokens=* delims=j" %%i in (deletion.dd) do (
echo Removing custom "%%i" ...
busybox sed -i -E "/%%i/d" nord.txt
)

echo Removing-OK!

echo Sorting...

set LC_ALL='C'
busybox sort -u -i -o nordv.tmxt nord.txt
set LC_ALL=

echo Sort-OK!

::count total rules
echo Counting...
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nordv.tmxt')do set/a rnum=%%a
echo Count-OK!

::get and save version code
echo Getting-codes...
for /f "tokens=1,2 delims=:" %%i in ('echo %time%') do (set v3=%%i%%j)
if not %v3% gtr 999 set v3=0%v3%
for /f "tokens=2 delims= " %%i in ('echo %date%') do (set v1=%%i)
for /f "tokens=1,2,3 delims=/" %%i in ('echo %v1%') do (set v2=%%k%%i%%j)
set vs=%v2%%v3%

for /f "tokens=1,2 delims=:" %%i in ('echo %time%') do (set g3=%%i:%%j)
for /f "tokens=1,2,3 delims=/" %%i in ('echo %v1%') do (set g1=%%k/%%i/%%j)
set gs=%g1% %g3%

::save info into file
::if local,disable this
::in order to update readme
if not exist ..\..\changelog md ..\..\changelog
if not exist ..\..\changelog\%MAINFOLD% md ..\..\changelog\%MAINFOLD%
echo {"schemaVersion":1,"label":"Last updated","color":"green","message":"%gs% (北京时间)"} > ..\..\changelog\%MAINFOLD%\date
echo {"schemaVersion":1,"label":"Version","color":"blue","message":"%vs%"} > ..\..\changelog\%MAINFOLD%\ver
echo {"schemaVersion":1,"label":"Rule count","color":"yellow","message":"%rnum%"} > ..\..\changelog\%MAINFOLD%\num

::add title and date to rule
echo ! Version: %vs%>tpdate.txt
echo ! Last modified: %gs% (北京时间)>>tpdate.txt
echo ! Count: %rnum%>>tpdate.txt
echo.>>tpdate.txt
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>>tpdate.txt
echo.>>tpdate.txt
echo Get-codes-OK!
type tpdate.txt

::final merge and use Adguard FOP
echo Merging use Adguard FOP ...
type title.dd>w.tmxt
type tpdate.txt>>w.tmxt
del /f /q .\*.txt
ren nordv.tmxt nordv.txt
python FOP.py | findstr Sorted
ren w.tmxt w.txt
type nordv.txt>>w.txt
type addition.dd>>w.txt
copy /y w.txt %MAINFOLD%.txt
echo Merge-OK!

::move file out
copy /y .\%MAINFOLD%.txt ..\..\
del /f /q .\*.txt&del /f /q .\*.exe&del /f /q .\*.py
set MAINFOLD=
cd ..
