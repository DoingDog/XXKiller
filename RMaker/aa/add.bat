echo ! Version: %date%>>tempdate.txt
echo ! Last modified: %date%T%time%Z>>tempdate.txt
copy tempdate.txt+w.txt ..\..\w.txt
del /f /q *.txt
exit
