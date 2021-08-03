echo ! Version: %date%>tempdate.txt
copy tempdate.txt+w.txt ..\w.txt
del /f /q *.txt
exit