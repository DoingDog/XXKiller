ren get.bat wget.exe
wget https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
del /f /q *hsts
del /f /q *.html
ren filter.txt i1.txt
wget https://halflife.coding.net/p/list/d/list/git/raw/master/ad-pc.txt
del /f /q *hsts
ren ad-pc.txt i2.txt
wget https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt
del /f /q *hsts
ren mv.txt i3.txt
wget https://banbendalao.coding.net/p/adgk/d/ADgk/git/raw/master/ADgk.txt
ren ADgk.txt i4.txt
del /f /q *hsts
wget https://hacamer.coding.net/p/lite/d/AdBlock-Rules-Mirror/git/raw/master/AdGuard-Simplified-Domain-Names-Filter.txt
del /f /q *hsts
ren Ad*.txt i5.txt
wget https://neodev.team/lite_adblocker
del /f /q *hsts
ren lit* i6.txt
wget https://anti-ad.net/easylist.txt
del /f /q *hsts
ren easylist.txt i7.txt
::co
ren wget.exe get.bat
call mic.bat
