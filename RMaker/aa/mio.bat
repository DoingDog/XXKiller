ren awk.bat gawk.exe
gawk "!a[$0]++" mgd.txt>what.txt
ren gawk.exe awk.bat
del /f /q mgd.txt
call mix.bat
