@echo off
cd /d %~dp0\aa

::start download files
u1.txt https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Privacy.list
2.txt https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Hijacking.list
wget -O i3.txt https://raw.githubusercontent.com/NobyDa/Script/master/Surge/AdRule.list
wget -O i4.txt https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/Advertising.list
wget -O i5.txt https://raw.githubusercontent.com/NobyDa/ND-AD/master/QuantumultX/AD_Block.txt
wget -O i6.txt https://raw.githubusercontent.com/NobyDa/ND-AD/master/QuantumultX/AD_Block_Plus.txt
wget -O i7.txt https://limbopro.com/Adblock4limbo.list
wget -O i8.txt https://raw.githubusercontent.com/DivineEngine/Profiles/master/Surge/Ruleset/Guard/AdvertisingPlus.list

::add new rules
::wget -O i+number url

::download finished
::Process rules

::del rubbish
::del /f /q *.html
del /f /q *hsts

(for /f "eol=# delims=" %%i in (u1.txt) do (echo %%i,REJECT))>>ia1.txt
(for /f "eol=# delims=" %%i in (u2.txt) do (echo %%i,REJECT))>>ia1.txt
(for /f "eol=# delims=" %%i in (u3.txt) do (echo %%i,REJECT))>>ia1.txt
(for /f "eol=# delims=" %%i in (u4.txt) do (echo %%i,REJECT))>>ia1.txt

::add blank line
for %%i in (i*.txt) do type blank.dd>>%%i

::Merge
type i*.txt>>mergd.txt

::delete repeated rules
gawk "!a[$0]++" mergd.txt>nore.txt

::process other lines
(findstr /v /b /e "#[^#]*" nore.txt)>final.txt

::end cleanup
copy /y final.txt ..\..\quantumult.list
del /f /q *.txt&exit
