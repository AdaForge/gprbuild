# `gprbuild` from AdaCore

This fork is a (slight) rework of the installation scripts and process as to build 
the software on exotic(!) OS systems as `macOS` & `FreeBSD`.

Aim is to have a working bootstrap on those plateforms.

## Major diffs with AdaCore's version

* up to date info about version #, date and year
* all build artefacts will lay in an dedicated  build directory
* corrected some gcc compiler switch typos in `*.gpr` files (`-gnat2022`)
* clean-up `.gitignore` file

## gprbuild Prerequisites

* Ada compiler. I use `gcc` (from GNU FSF)
* [gprconfig_kb](https://github.com/AdaCore/gprconfigure_kb)
* [xmlada](https://github.com/AdaCore/xmlada)

## Configuration as code

* Build directory is a sub-directory of the gprbuild project
* gprconfig and xmlada are located at thi same level as gprbuild
* `GPR_PROJECT_PATH` defaults to `/home/william/usr/local/share/gpr`


## Environment vaiables

`DISTDIR=`your installation location WITH a TRAILING slash '/'; defaults to `/usr/local`

Optional
`CC=`(...your C/Ada compiler)
`CXX=`(...your C++ compiler)
`GNATMAKE=`(...your C/Ada compiler)


When compiling, you can choose whether you want to link statically with XML/Ada
(the default), or dynamically. To compile dynamically, you should run:

```Make
make LIBRARY_TYPE=relocatable all
```

### Sample

```Shell
export DISTDIR=/users/william
export CC=/home/william/usr/local/gcc-12.2.0/bin/gcc
export CXX=/home/william/usr/local/gcc-12.2.0/bin/g++
export GNATMAKE=/home/william/usr/local/gcc-12.2.0/bin/gnatmake
```

### FreeBSD tweek

`export  GNATMAKEFLAGS=-L/usr/lib`
or for a permanent setting:
```Shell
ln -sv /usr/lib/libpthread.* /home/william/usr/local/gcc-12.2.0/lib/gcc/x86_64-unknown-freebsd13.1/12.2.0/adalib
ln -sv /usr/lib/libc.* /home/william/usr/local/gcc-12.2.0/lib/gcc/x86_64-unknown-freebsd13.1/12.2.0/adalib
```

# Steps

Steps noted as `0.` are done just once.

Go through the other steps after a clean-up of the build

### `0.a` Get the software

```Shell
git pull https://github.com/AdaCore/gprbuild.git 
git pull https://github.com/AdaCore/gprconfigure_kb.git 
git pull https://github.com/AdaCore/xmlada.git 
```

### `0.b` Set environment variables

```Shell
export  GNATMAKEFLAGS=-L/usr/lib
mkdir -p gprbuild/build
cd gprbuild/build
```

### 1. Build a first temporary `gprbuild` (ligth) = Bootstrap

```Shell
cd gprbuild/build
../bootstrap.sh --with-xmlada=../../xmlada.git --with-kb=../../gprconfig_kb.git --prefix=./bootstrap --srcdir=..
```

### 2. Prepare build = Configure the `Makefile`
* you are in `.../gprbuild/build`
```Shell
gmake -f ../Makefile prefix=/Store/users/william/usr/local SOURCE_DIR=.. setup
```

### 3. Launch the build of the full `gprbuild`
* you are in `.../gprbuild/build`
```Shell
gmake -f ../Makefile all
(sudo) gmake -f ../Makefile install
```

### 99. Clean-up
* you are in `.../gprbuild/build`

```Shell
cd ..
make clean  # cleanup
```
or more straightforward:
```Shell
cd ..
rm -r build

```

# Doc & Examples
[online at AdaCore](http://docs.adacore.com/gprbuild-docs/html/gprbuild_ug.html).

## Prerequisites
TBD
