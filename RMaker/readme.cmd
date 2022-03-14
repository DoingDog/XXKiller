@echo off
chcp 65001
cd %~dp0\..
cls

for /f "tokens=* delims=" %%a in (.\RMaker\aa\info1.log) do (
    set a=%%a
    echo %%a
    sed -i -E --posix "s/count:.+$/count:%a%/g" README.md
)
for /f "tokens=* delims=" %%a in (.\RMaker\aa\info2.log) do (
    set a=%%a
    echo %%a
    sed -i -E --posix "s/version:.+$/version:%a%/g" README.md
)
for /f "tokens=* delims=" %%a in (.\RMaker\aa\info3.log) do (
    set a=%%a
    echo %%a
    sed -i -E --posix "s/update:.+$/update:%a%/g" README.md
)
del /f /q .\RMaker\aa\*.log
exit