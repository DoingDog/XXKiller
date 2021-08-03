echo ! Version: %date%-%time%>tempdate.txt
copy tempdate.txt+w.txt ..\w.txt
del /f /q *.txt
exit