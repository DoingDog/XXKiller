ren get.bat wget.exe
::start don
setlocal enabledelayedexpansion
@echo off



::此处修改规则总数
set rnum=9
::此处添加链接
set link1=https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
set link2=https://halflife.coding.net/p/list/d/list/git/raw/master/ad-pc.txt
set link3=https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt
set link4=https://banbendalao.coding.net/p/adgk/d/ADgk/git/raw/master/ADgk.txt
set link5=https://hacamer.coding.net/p/lite/d/AdBlock-Rules-Mirror/git/raw/master/AdGuard-Simplified-Domain-Names-Filter.txt
set link6=https://neodev.team/lite_adblocker
set link7=http://file.trli.club/dns/hosts.txt
set link8=https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/manhua.txt
set link9=https://anti-ad.net/easylist.txt



set lp=1
:downloop
wget -O i%lp%.txt !link%lp%!
del /f /q *hsts
del /f /q *.html
if %lp%==%rnum% goto :enddownloop
set/a lp=%lp%+1
goto :downloop
:enddownloop
ren wget.exe get.bat
call mic.bat
