@echo off
cd /d %~dp0\aa

::start download files

wget -O i1.txt https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
wget -O i2.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-pc.txt
wget -O i3.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt
wget -O i4.txt https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt
wget -O i5.txt https://file.trli.club/dns/whitelist.txt
wget -O i6.txt https://neodev.team/lite_adblocker
wget -O i7.txt https://file.trli.club/dns/hosts.txt
wget -O i8.txt https://anti-ad.net/easylist.txt
wget -O i10.txt https://adaway.org/hosts.txt
wget -O i11.txt https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt
wget -O i12.txt https://anti-ad.net/adguard.txt
wget -O i13.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/rule.txt

::add new rules like wget -O i+number url

::download finished

::del rubbish
del /f /q *hsts

::add blank line
for %%i in (i*.txt) do type blank.dd>>%%i

::Merge
type frules.dd>>mergd.txt
type i*.txt>>mergd.txt

::delete repeated rules
gawk "!a[$0]++" mergd.txt>norm.txt
(sort /rec 65535 norm.txt)>nore.txt

::delete comments&rubbish
(findstr /b /c:"@" nore.txt)>nord.txt
copy /y nord.txt ..\..\xw.txt
(findstr /v /b /c:"@" /c:"# " /c:"！" /c:"[" /c:"!" nore.txt)>>nord.txt

::count rules
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nord.txt')do set/a rnum=%%a+1
::save
echo %rnum%>..\..\ct.txt

::add title and date
echo ! Version: %date%>>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
echo ! Rule Count: %rnum%>>tpdate.txt
copy title.dd+tpdate.txt+nord.txt+brules.dd final.txt

::end cleanup
copy /y final.txt ..\..\w.txt
del /f /q *.txt&exit
