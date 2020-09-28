REM 
REM 
REM 

for /f %%i in ("%0") do set TESTDIR=%%~dpi

set MAIN=CAD

set CXP_LOG=2
set CXP_PATH=%TESTDIR%../..//
REM set LANG=
set LANG=en
REM set TMPDIR=%TESTDIR%tmp_%LANG%
set TMPDIR=%TESTDIR%tmp

set PATH="C:\UserData\Programme\graphviz\bin";"C:\UserData\Develop\cxproc-build\x86-windows-debug\bin";%PATH%

md %TMPDIR%

cxproc.exe PkgProcessMain.cxp %MAIN%.pie 2> %TMPDIR%\main.log

REM pause
REM robocopy %TMPDIR% %TESTDIR%..\..\www\html\Documents *.*

