@echo off
chcp 65001
cd %~dp0\aa
cls
curl -k -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4937.0 Safari/537.36" https://purge.jsdelivr.net/gh/DoingDog/XXKiller@main/w.txt|findstr true&&echo Purge-Failed&&goto :finished
echo Purge-Finished
:finished
exit