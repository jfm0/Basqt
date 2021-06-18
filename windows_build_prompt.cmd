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
REM This path contains the compiled qt tools
SET PATH=%PATH%;%mypath%\build\qt5\qtbase\bin


REM Contrary to earlier recommendations, do NOT set QMAKESPEC.

REM Multicore
set CL=/MP

set BUILD_OPENSSL_DIR=%mypath%\build\openssl
set INSTALL_OPENSSL_DIR=%mypath%\bin\openssl
set BUILD_QT_DIR=%mypath%\build\qt5
set CONFIG_TYPE=Debug

set BUILD_SDL2_DIR=%mypath%\build\SDL2
set INSTALL_SDL2_DIR=%mypath%\bin\SDL2

set BUILD_GRPC_DIR=%mypath%\build\grpc
set INSTALL_GRPC_DIR=%mypath%\bin\grpc

set BUILD_ABSL_DIR=%mypath%\build\grpc\third_party\abseil-cpp
set INSTALL_ABSL_DIR=%mypath%\bin\absl

set BUILD_CARES_DIR=%mypath%\build\grpc\third_party\cares
set INSTALL_CARES_DIR=%mypath%\bin\cares

set BUILD_PROTOBUF_DIR=%mypath%\build\grpc\third_party\protobuf
set INSTALL_PROTOBUF_DIR=%mypath%\bin\protobuf

set BUILD_RE2_DIR=%mypath%\build\grpc\third_party\re2
set INSTALL_RE2_DIR=%mypath%\bin\re2

set BUILD_ZLIB_DIR=%mypath%\build\grpc\third_party\zlib
set INSTALL_ZLIB_DIR=%mypath%\bin\zlib

set CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH%;%mypath%\bin\grpc\cmake;
set CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH%;%mypath%\bin

set INSTALL_ZLIB_DIR=%mypath%\bin
set INSTALL_RE2_DIR=%mypath%\bin
set INSTALL_PROTOBUF_DIR=%mypath%\bin
set INSTALL_CARES_DIR=%mypath%\bin
set INSTALL_ABSL_DIR=%mypath%\bin
set INSTALL_SDL2_DIR=%mypath%\bin
set INSTALL_OPENSSL_DIR=%mypath%\bin
set INSTALL_GRPC_DIR=%mypath%\bin

REM ######################## openssl ############################
REM Compile openssl
if NOT EXIST %INSTALL_OPENSSL_DIR%\lib\libssl.lib (
ECHO Build OpenSsl
mkdir %BUILD_OPENSSL_DIR%
pushd %BUILD_OPENSSL_DIR%
CALL perl %mypath%\openssl\Configure VC-WIN64A --prefix=%INSTALL_OPENSSL_DIR% --openssldir=%INSTALL_OPENSSL_DIR%
CALL nmake
CALL nmake install
popd
)

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

if NOT EXIST %BUILD_QT_DIR%\qtbase\bin\qmake.exe (
ECHO Build Qt
REM $ mkdir %BUILD_QT_DIR%
REM $ pushd %BUILD_QT_DIR%
REM $ %mypath%\qt5\configure -developer-build -opensource -nomake examples -nomake tests -confirm-license -openssl-runtime OPENSSL_PREFIX="%INSTALL_OPENSSL_DIR%" -native-win32-bluetooth
REM $ nmake
REM popd
)

REM ######################## SDL2 ############################

if NOT EXIST %INSTALL_SDL2_DIR%\include\SDL2\SDL.h (
ECHO Build SDL2
mkdir %BUILD_SDL2_DIR%
pushd %BUILD_SDL2_DIR%
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_SDL2_DIR% %mypath%\SDL-mirror
cmake --build . --config %CONFIG_TYPE%
cmake --install . --config %CONFIG_TYPE%
popd
)

REM ######################## ABSL abseil ############################

if NOT EXIST %INSTALL_ABSL_DIR%\include\absl (
ECHO Build ABSL
mkdir %BUILD_ABSL_DIR%
pushd %BUILD_ABSL_DIR%
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_ABSL_DIR% -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE %mypath%\grpc\third_party\abseil-cpp
cmake --build . --config %CONFIG_TYPE%
cmake --install . --config %CONFIG_TYPE%
popd
)

REM ######################## CARES ############################

if NOT EXIST %INSTALL_CARES_DIR%\include\ares.h (
ECHO Build CARES
mkdir %BUILD_CARES_DIR%
pushd %BUILD_CARES_DIR%
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_CARES_DIR% -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE %mypath%\grpc\third_party\cares\cares
cmake --build . --config %CONFIG_TYPE%
cmake --install . --config %CONFIG_TYPE%
popd
)

REM ######################## PROTOBUF ############################
if NOT EXIST %INSTALL_PROTOBUF_DIR%\include\google\protobuf (
ECHO Build PROTOBUF
mkdir %BUILD_PROTOBUF_DIR%
pushd %BUILD_PROTOBUF_DIR%
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_PROTOBUF_DIR% -Dprotobuf_MSVC_STATIC_RUNTIME=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE %mypath%\grpc\third_party\protobuf\cmake
cmake --build . --config %CONFIG_TYPE%
cmake --install . --config %CONFIG_TYPE%
popd
)

REM ######################## RE2 ############################
if NOT EXIST %INSTALL_RE2_DIR%\include\re2\re2.h (
ECHO Build RE2
mkdir %BUILD_RE2_DIR%
pushd %BUILD_RE2_DIR%
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_RE2_DIR% -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE %mypath%\grpc\third_party\re2
cmake --build . --config %CONFIG_TYPE%
cmake --install . --config %CONFIG_TYPE%
popd
)

REM ######################## SSL ############################
REM uses OpenSSL instead of BoringSSL

REM ######################## ZLIB ############################
if NOT EXIST %INSTALL_ZLIB_DIR%\include\zlib.h (
ECHO Build ZLIB
mkdir %BUILD_ZLIB_DIR%
pushd %BUILD_ZLIB_DIR%
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_ZLIB_DIR% -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE %mypath%\grpc\third_party\zlib
cmake --build . --config %CONFIG_TYPE%
cmake --install . --config %CONFIG_TYPE%
popd
)

REM ######################## GRPC ############################
if NOT EXIST %INSTALL_GRPC_DIR%\bin\bin\grpc_cpp_plugin.exe (
ECHO Build GRPC
mkdir %BUILD_GRPC_DIR%
pushd %BUILD_GRPC_DIR%
REM need to define Protobuf_USE_STATIC_LIBS because FindProtobuf.cmake is forcing PROTOBUF_USE_DLLS on
cmake -DgRPC_INSTALL=ON -DProtobuf_USE_STATIC_LIBS=ON -DCMAKE_INSTALL_PREFIX=%INSTALL_GRPC_DIR% -DgRPC_ABSL_PROVIDER=package -DgRPC_CARES_PROVIDER=package -DgRPC_PROTOBUF_PROVIDER=package -DgRPC_RE2_PROVIDER=package -DgRPC_SSL_PROVIDER=package -DgRPC_ZLIB_PROVIDER=package %mypath%\grpc
cmake --build . --config %CONFIG_TYPE%
cmake --install . --config %CONFIG_TYPE%
popd
)

REM Keeps the command line open when this script is run.
cmd /k