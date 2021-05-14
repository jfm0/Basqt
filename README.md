# Basqt

Basic Qt application incorporating additional libraries

Build based on https://wiki.qt.io/Building_Qt_5_from_Git except webview related modules were removed to speed up building since they were not needed.

# Fetching

1. Clone this repository: `git clone https://github.com/jfm0/Basqt`
2. Get submodules: `git submodule update --init --recursive --progress` from the Basqt folder


# Forked repositories/submodules

## Git Submodules

Submodules added:
```
git submodule add -b 5.15.2 https://github.com/jfm0/qt5.git qt5
git submodule add -b OpenSSL_1_1_1-stable https://github.com/jfm0/openssl.git openssl
git submodule add -b master https://github.com/jfm0/angle.git angle
git submodule add -b uPyEsp https://github.com/jfm0/SDL-mirror.git
```

Modifications:

* Changed qt5/.gitmodules to point submodules to absolute github paths
* Removed qt5 submodules: webview

## Windows:

windows_build_prompt.cmd

1. Build OpenSSL:

Replace %mypath% below with absolute path to build-openssl folder

From openssl folder:
```
perl Configure VC-WIN64A --prefix=%mypath%`
nmake
nmake install
```

2. Building Qt 5.15.2:

From Basqt folder:
```
mkdir bin-qt5
cd bin-qt5
..\qt5\configure -developer-build -opensource -nomake examples -nomake tests -confirm-license 
nmake
```

3. Setup Kit 'Qt 5.15.2' in QtCreator:

    **Note:** From https://stackoverflow.com/questions/30553318/cmake-cl-exe-is-not-able-to-compile-a-simple-test-program

    "In case Qt Creator 4.7.0 with CMake: I solved this problem by changing generator from 'NMake Makefiles JOM' to 'NMake Makefiles' in Tools->Options->Kits->Kits[->Qt 5.15.2]->CMake generator."

