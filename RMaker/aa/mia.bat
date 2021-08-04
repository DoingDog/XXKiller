ren get.bat wget.exe
::start don
@echo off
::p
wget https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
del /f /q *hsts
del /f /q *.html
ren filter.txt i1.txt
::p
wget https://halflife.coding.net/p/list/d/list/git/raw/master/ad-pc.txt
del /f /q *hsts
ren ad-pc.txt i2.txt
::p
wget https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt
del /f /q *hsts
ren mv.txt i3.txt
::p
wget https://banbendalao.coding.net/p/adgk/d/ADgk/git/raw/master/ADgk.txt
ren ADgk.txt i4.txt
del /f /q *hsts
::p
wget https://hacamer.coding.net/p/lite/d/AdBlock-Rules-Mirror/git/raw/master/AdGuard-Simplified-Domain-Names-Filter.txt
del /f /q *hsts
ren Ad*.txt i5.txt
::p
wget https://neodev.team/lite_adblocker
del /f /q *hsts
ren lit* i6.txt
::p
wget http://file.trli.club/dns/hosts.txt
del /f /q *hsts
ren hos*.txt i9.txt
::p
wget https://anti-ad.net/easylist.txt
del /f /q *hsts
ren easylist.txt i7.txt
::p
wget https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/manhua.txt
del /f /q *hsts
ren man*.txt i8.txt
::p
::新的规则
::wget url
::del /f /q *hsts
::ren filename.txt inumber.txt
ren wget.exe get.bat
call mic.bat
