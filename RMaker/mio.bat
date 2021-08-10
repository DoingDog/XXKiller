@echo off
cd /d %~dp0\aa

::start download files

wget -O i1.txt https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
wget -O i2.txt https://halflife.coding.net/p/list/d/list/git/raw/master/ad-pc.txt
wget -O i3.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt
wget -O i4.txt https://banbendalao.coding.net/p/adgk/d/ADgk/git/raw/master/ADgk.txt
wget -O i5.txt https://hacamer.coding.net/p/lite/d/AdBlock-Rules-Mirror/git/raw/master/AdGuard-Simplified-Domain-Names-Filter.txt
wget -O i6.txt https://neodev.team/lite_adblocker
wget -O i7.txt http://file.trli.club/dns/hosts.txt
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

::Merge
type frules.dd>>mergd.txt
type i*.txt>>mergd.txt

::delete repeated rules
gawk "!a[$0]++" mergd.txt>nore.txt

::delete comments
(for /f "eol=/ delims=" %%i in (nore.txt) do (echo %%i))>ntpa.txt
(findstr /vbe "#[^#]*" ntpa.txt)>ntpf.txt
(for /f "eol=! delims=" %%i in (ntpf.txt) do (echo %%i))>ntps.txt
(for /f "eol=[ delims=" %%i in (ntps.txt) do (echo %%i))>ntpt.txt

::count rules
for /f "tokens=2 delims=:" %%i in ('find /c /v "" nord.txt')do set /a rnum=%%i
::error
set /a rnum+=1

::add title and date
echo ! Version: %date%-count=%rnum%>>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
echo ! Count: %rnum%>>tpdate.txt
copy title.dd+tpdate.txt+nord.txt+brules.dd final.txt

::end cleanup
copy /y final.txt ..\..\w.txt
del /f /q *.txt&exit
