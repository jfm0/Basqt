@echo off

SET mypath=%~dp0

pushd %mypath%
rem x86_amd64
SET PATH=C:\Python37;C:\Python37\Scripts;C:\Strawberry\perl\bin;%PATH%

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64

REM Edit this location to point to the source code of Qt
SET QT_ROOT=%mypath%\qt5

SET PATH=%QT_ROOT%\qtbase\bin;%QT_ROOT%\gnuwin32\bin;%PATH%

REM Uncomment the below line when using a git checkout of the source repository
SET PATH=%QT_ROOT%\qtrepotools\bin;%PATH%

REM Uncomment the below line when building with OpenSSL enabled. If so, make sure the directory points
REM to the correct location (binaries for OpenSSL).
SET PATH=%mypath%\bin-openssl\bin;%PATH%

REM When compiling with ICU, uncomment the lines below and change <icupath> appropriately:
REM SET INCLUDE=%mypath%\icu\include;%INCLUDE%
REM SET LIB=%mypath%\icu\lib;%LIB%
REM SET PATH=%mypath%\icu\lib;%PATH%

REM Contrary to earlier recommendations, do NOT set QMAKESPEC.

SET QT_ROOT=

REM Multicore
set CL=/MP

REM Compile openssl
REM >    mkdir %mypath%\bin-openssl
REM >    pushd openssl
REM >    CALL perl Configure VC-WIN64A --prefix=%mypath%\bin-openssl
REM >    CALL nmake

REM Compile ICU

REM The absolute paths of include and lib folders of the ICU installation must be passed with -I and -L option to Qt's configure



REM $ mkdir bin-qt5
REM $ cd bin-qt5
REM $ ..\qt5\configure -developer-build -opensource -nomake examples -nomake tests -confirm-license 
REM $ nmake

REM Keeps the command line open when this script is run.
cmd /k