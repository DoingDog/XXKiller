@echo off
chcp 65001
cd %~dp0\aa
cls

for /f "tokens=* delims=" %%a in (info1.log) do (
    echo %%a
    sed -i -E --posix "s/count:.+$/count:%%a/g" ..\..\README.md
)
for /f "tokens=* delims=" %%a in (info2.log) do (
    echo %%a
    sed -i -E --posix "s/version:.+$/version:%%a/g" ..\..\README.md
)
for /f "tokens=* delims=" %%a in (info3.log) do (
    echo %%a
    sed -i -E --posix "s/update:.+$/update:%%a/g" ..\..\README.md
)
del /f /q *.log
exit