REM 
REM 
REM 

for /f %%i in ("%0") do set TESTDIR=%%~dpi

set MAIN=workflow
set CXP_LOG=2
set CXP_PATH=%TESTDIR%../..//
REM set LANG=
set LANG=en
REM set TMPDIR=%TESTDIR%tmp_%LANG%
set TMPDIR=%TESTDIR%tmp

set PATH="C:\UserData\Programme\graphviz\bin";"C:\UserData\Develop\cxproc-build\x86-windows-debug\bin";%PATH%

md %TMPDIR%

REM robocopy net\man %TMPDIR%\man *.txt

REM cxproc.exe PkgProcessPre.cxp net\%MAIN%.pie 2> %TMPDIR%\main.log

cxproc.exe PkgProcessMain.cxp %MAIN%.pie 2> %TMPDIR%\main.log

REM
REM if exist \%TMPDIR%\index.html explorer.exe \%TMPDIR%\index.html

REM pause
REM robocopy %TMPDIR% %TESTDIR%..\..\www\html\Documents *.*

