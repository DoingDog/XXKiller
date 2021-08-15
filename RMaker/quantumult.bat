@echo off
cd /d %~dp0\aa

::start download files

::noreject
wget -O u1.txt https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Privacy.list
wget -O u2.txt https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Hijacking.list
wget -O u3.txt https://raw.githubusercontent.com/NobyDa/Script/master/Surge/AdRule.list
wget -O u5.txt https://anti-ad.net/surge.txt
wget -O u4.txt https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Advertising.list
::fine
wget -O i5.txt https://raw.githubusercontent.com/NobyDa/ND-AD/master/QuantumultX/AD_Block.txt
wget -O i6.txt https://raw.githubusercontent.com/NobyDa/ND-AD/master/QuantumultX/AD_Block_Plus.txt
::caps and blank
wget -O u7.txt https://limbopro.com/Adblock4limbo.list
::all
wget -O u8.txt https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/AdvertisingPlus.list
type blank.dd>>u8.txt

::hosts
wget -O uh1.txt https://neodev.team/lite_host
wget -O uh2.txt https://adaway.org/hosts.txt
wget -O uh3.txt https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt


for %%i in (uh*.txt) do type blank.dd>>%%i
type uh*.txt>>ug.txt

del /f /q *hsts
:h2qx
setlocal enabledelayedexpansion
(for /f "eol=# delims=" %%a in ('type ug.txt') do (
	set "str=%%a"
	set str=!str: =#!
	for /f "tokens=2 delims=#" %%A in ("!str!") do (set /p =%%A<nul &echo,)
))>>u8.txt

setlocal enabledelayedexpansion
for /f "delims=" %%i in ('type "u7.txt"') do (
   set str=%%i
   set "str=!str:reject=REJECT!"
   echo !str!>>i7.txt
)
endlocal
(for /f "eol=# delims=" %%i in (u5.txt) do (echo %%i,REJECT))>>ia1.txt
(for /f "eol=# delims=" %%i in (u1.txt) do (echo %%i,REJECT))>>ia1.txt
(for /f "eol=# delims=" %%i in (u2.txt) do (echo %%i,REJECT))>>ia1.txt
(for /f "eol=# delims=" %%i in (u3.txt) do (echo %%i,REJECT))>>ia1.txt
(for /f "eol=# delims=" %%i in (u4.txt) do (echo %%i,REJECT))>>ia1.txt
(for /f "eol=# delims=" %%i in (u8.txt) do (echo %%i,REJECT))>>ut.txt


(for /f "eol=. delims=" %%i in (ut.txt) do (echo DOMAIN,%%i))>>ix1.txt

setlocal enabledelayedexpansion
(for /f "delims=" %%i in ('findstr "^\." ut.txt') do (
        set line=%%i
        echo;DOMAIN-SUFFIX,!line:~1!
))>ix2.txt

endlocal

::add blank line
for %%i in (i*.txt) do type blank.dd>>%%i

::Merge
type i*.txt>>mergd.txt

setlocal enabledelayedexpansion
(for /f "delims=" %%i in (mergd.txt) do (
        set line=%%i
        echo;!line: =!
))>mergd1.txt
endlocal

::delete repeated rules
gawk "!a[$0]++" mergd1.txt>nore.txt

::process other lines
(findstr /v /b /e "#[^#]*" nore.txt)>final.txt
type qxwl.dd>>final.tx
type final.txt>>final.tx

::end cleanup
copy /y final.tx ..\..\quantumult.list
del /f /q *.txt&exit
