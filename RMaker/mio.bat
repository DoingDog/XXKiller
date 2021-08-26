@echo off
cd /d %~dp0\aa

::start download files

wget -O i1.txt https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
wget -O i2.txt https://halflife.coding.net/p/list/d/list/git/raw/master/ad-pc.txt
wget -O i3.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt
wget -O i4.txt https://banbendalao.coding.net/p/adgk/d/ADgk/git/raw/master/ADgk.txt
wget -O i5.txt https://hacamer.coding.net/p/lite/d/AdBlock-Rules-Mirror/git/raw/master/AdGuard-Simplified-Domain-Names-Filter.txt
wget -O i6.txt https://neodev.team/lite_adblocker
wget -O i7.txt https://file.trli.club/dns/hosts.txt
wget -O i8.txt https://anti-ad.net/easylist.txt
wget -O i9.txt https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/manhua.txt
wget -O i10.txt https://adaway.org/hosts.txt
wget -O i11.txt https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt
wget -O i12.txt https://anti-ad.net/adguard.txt
wget -O i13.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/rule.txt

::add new rules
::wget -O i+number url

::download finished
::Process rules

::del rubbish
::del /f /q *.html
del /f /q *hsts

::add blank line
for %%i in (i*.txt) do type blank.dd>>%%i

::Merge
type frules.dd>>mergd.txt
type i*.txt>>mergd.txt

::delete repeated rules
gawk "!a[$0]++" mergd.txt>nore.txt

::delete comments

::extract and move lines with "/"
(findstr /r /b "^/." nore.txt)>ntp1.txt
(findstr /r /v /b "^/." nore.txt)>ntpa.txt

::process other lines
(for /f "eol=! delims=" %%i in (ntpa.txt) do (echo %%i))>ntpc.txt
(for /f "eol=[ delims=" %%i in (ntpc.txt) do (echo %%i))>nord.txt

::merge lines
type ntp1.txt>>nord.txt

::count rules
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nord.txt')do set/a rnum=%%a
::error
set/a rnum+=1
::save ct
echo %rnum%>..\..\ct.txt

::add title and date
echo ! Version: %date%>>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
echo ! Count: %rnum%>>tpdate.txt
copy title.dd+tpdate.txt+nord.txt+brules.dd final.txt

::end cleanup
copy /y final.txt ..\..\w.txt
del /f /q *.txt&exit
