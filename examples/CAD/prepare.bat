REM 
REM 
REM 

for /f "delims=" %%i in ("%0") do set TESTDIR=%%~dpi

set MAIN=cad
set TMPDIR=%TESTDIR%tmp
REM set TMPDIR=C:\User\develop\cxproc-build\trunk\x86-windows-debug-dynamic\www\html\pkg2-cad
set CXP_LOG=2
set CXP_PATH=%TESTDIR%..//
REM set LANG=en

set PATH="C:\User\Programme\graphviz\bin";"C:\User\develop\cxproc-build\trunk\x86-windows-debug-dynamic\bin";%PATH%

md %TMPDIR%

cxproc.exe PkgProcessMain.cxp %MAIN%.pie 2> %TMPDIR%\main.log

REM pause
