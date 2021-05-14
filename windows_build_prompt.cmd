@echo off

SET mypath=%~dp0

pushd %mypath%
rem x86_amd64
SET PATH=C:\Python37;C:\Python37\Scripts;C:\Strawberry\perl\bin;%PATH%

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64

REM Edit this location to point to the source code of Qt
SET QT_ROOT=%mypath%\qt5

SET PATH=%QT_ROOT%\qtbase\bin;%QT_ROOT%\gnuwin32\bin;%PATH%;

REM this is for nasm
set PATH=%PATH%;C:\msys64\usr\bin

REM Uncomment the below line when using a git checkout of the source repository
SET PATH=%QT_ROOT%\qtrepotools\bin;%PATH%


REM Contrary to earlier recommendations, do NOT set QMAKESPEC.

REM Multicore
set CL=/MP

set BUILD_OPENSSL_DIR=%mypath%\build\openssl
set INSTALL_OPENSSL_DIR=%mypath%\bin\openssl
set BUILD_QT_DIR=%mypath%\build\qt5
set CONFIG_TYPE=Debug
set BUILD_SDL2_DIR=%mypath%\build\SDL2
set INSTALL_SDL2_DIR=%mypath%\bin\SDL2

REM ######################## openssl ############################
REM Compile openssl
REM >    mkdir %BUILD_OPENSSL_DIR%
REM >    pushd %BUILD_OPENSSL_DIR%
REM >    CALL perl %mypath%\openssl\Configure VC-WIN64A --prefix=%INSTALL_OPENSSL_DIR%
REM >    CALL nmake
REM >    CALL nmake install

REM Uncomment the below line when building with OpenSSL enabled. If so, make sure the directory points
REM to the correct location (binaries for OpenSSL).
SET PATH=%BUILD_OPENSSL_DIR%\bin;%PATH%

REM ######################## ICU ################################

REM !!!TODO!!! Compile ICU
REM When compiling with ICU, uncomment the lines below and change <icupath> appropriately:
REM SET INCLUDE=%mypath%\icu\include;%INCLUDE%
REM SET LIB=%mypath%\icu\lib;%LIB%
REM SET PATH=%mypath%\icu\lib;%PATH%

REM The absolute paths of include and lib folders of the ICU installation must be passed with -I and -L option to Qt's configure

SET QT_ROOT=
REM ######################## QT ################################

REM $ mkdir %BUILD_QT_DIR%
REM $ pushd %BUILD_QT_DIR%
REM $ %mypath%\qt5\configure -developer-build -opensource -nomake examples -nomake tests -confirm-license -openssl-runtime OPENSSL_PREFIX="%INSTALL_OPENSSL_DIR%"
REM $ nmake


REM ######################## SDL2 ############################

REM Compile SDL
REM > mkdir %BUILD_SDL2_DIR%
REM > pushd %BUILD_SDL2_DIR%
REM > cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_SDL2_DIR% %mypath%\SDL-mirror
REM > cmake --build . --config %CONFIG_TYPE%
REM > cmake --install . --config %CONFIG_TYPE%
REM > popd


REM Keeps the command line open when this script is run.
cmd /k