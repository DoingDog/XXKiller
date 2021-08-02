@echo off
ren awk.bat gawk.exe
@gawk "!a[$0]++" mgd.txt>m-ad-mg.txt
ren gawk.exe awk.bat
move m-ad-mg.txt ..\what.txt
del /f /q mgd.txt
exit