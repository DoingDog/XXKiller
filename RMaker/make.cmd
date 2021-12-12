::init
@echo off
cd /d %~dp0\aa

::start download files

wget -O i1.txt https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
wget -O i2.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad-pc.txt
wget -O i3.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt
wget -O i4.txt https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt
wget -O i5.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/allow.txt
wget -O i6.txt https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_adblocker
wget -O i7.txt https://raw.githubusercontent.com/uniartisan/adblock_list/master/adblock_plus.txt
wget -O i8.txt https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt
wget -O i9.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/dnsfilter/aa/brules.dd
wget -O i10.txt https://adaway.org/hosts.txt
wget -O i11.txt https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt
wget -O i12.txt https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-adguard.txt
wget -O i13.txt https://gitee.com/xinggsf/Adblock-Rule/raw/master/rule.txt
wget -O i14.txt https://www.i-dont-care-about-cookies.eu/abp/
wget -O i15.txt https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener-AffiliateTagAllowlist.txt
wget -O i16.txt https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt
wget -O i17.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt
wget -O i18.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/lan-block.txt
wget -O i19.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt
wget -O i20.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt
::add new rules like wget -O i+number url

::download finished

::del rubbish
if exist .\*hsts del /f /q *hsts

::add blank line
for %%s in (i*.txt) do type blank.dd>>%%s

::Merge
type frules.dd>mergd.txt
type i*.txt>>mergd.txt

::delete repeated rules
set LC_ALL='C'
::sort rules Random flag -R
s -u --output=nore.txt mergd.txt

::delete comments&rubbish
(findstr /v /b /c:"# " /c:"[" /c:"!" nore.txt)>nord.txt

::count rules
for /f "tokens=2 delims=:" %%a in ('find /c /v "" nord.txt')do set/a rnum=%%a+1
::save ct
echo %rnum%>..\..\ct.txt

::add title and date
echo ! Version: %date%>tpdate.txt
echo ! Last modified: %date%T%time%Z>>tpdate.txt
echo ! Rule Count: %rnum%>>tpdate.txt
echo.>>tpdate.txt
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>>tpdate.txt
echo.>>tpdate.txt
::copy title.dd+tpdate.txt+nord.txt+brules.dd final.txt

::end cleanup
copy /y nord.txt ..\..\w.txt
del /f /q *.txt&exit
