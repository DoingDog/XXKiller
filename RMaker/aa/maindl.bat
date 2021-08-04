@echo off

::start download

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

::add new rules
::wget -O i+number url

::end download

::no need to change
del /f /q *.html
del /f /q *hsts
call mio.bat
