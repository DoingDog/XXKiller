@echo off
cd /d %~dp0\..\aa

copy frontshadow.dd+final.tx+backshadow.dd mergd.txt

::delete repeated rules
gawk "!a[$0]++" mergd.txt>nore.txt

::process other lines
(findstr /v /b /e "#[^#]*" nore.txt)>final.txt

::end cleanup
copy /y final.txt ..\..\shadow.conf
del /f /q *.txt&del /f /q final.tx&exit
