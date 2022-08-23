# gprbuild from AdaCore

This fork is a (slight) rework of the installation scripts and process as to build 
the software on exotic(!) OS systems as '''macOS''' & '''FreeBSD'''.

Aim si to have a working bootstrap on those plateforms.

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

### Sample

'''Shell
export DISTDIR=/users/william
export CC=/home/william/usr/local/gcc-12.2.0/bin/gcc
export CXX=/home/william/usr/local/gcc-12.2.0/bin/g++
export GNATMAKE=/home/william/usr/local/gcc-12.2.0/bin/gnatmake
'''

### FreeBSD tweek

`export  GNATMAKEFLAGS=-L/usr/lib`
or for permanent
'''Shell
ln -sv /usr/lib/libpthread.* /home/william/usr/local/gcc-12.2.0/lib/gcc/x86_64-unknown-freebsd13.1/12.2.0/adalib
ln -sv /usr/lib/libc.* /home/william/usr/local/gcc-12.2.0/lib/gcc/x86_64-unknown-freebsd13.1/12.2.0/adalib
'''

## Steps

### 0.a Prerequisites - get the software

'''Shell
git pull https://github.com/AdaCore/gprbuild.git 
git pull https://github.com/AdaCore/gprconfigure_kb.git 
git pull https://github.com/AdaCore/xmlada.git 
'''

### 0.b Set environment variables

'''Shell
export  GNATMAKEFLAGS=-L/usr/lib
mkdir build
build
'''

### 1. Build a first temporary `gprbuild` (ligth) = Bootstrap

'''Shell
../bootstrap.sh --with-xmlada=../../xmlada.git --with-kb=../../gprconfig_kb.git --prefix=./bootstrap --srcdir=..
'''

### 2. Prepare gprbuild = Conifigure the `Makefile`

'''Shell
gmake -f ../Makefile prefix=/Store/users/william/usr/local SOURCE_DIR=.. setup
'''

### 3. Build the full `gprbuild`

'''Shell
gmake -f ../Makefile all
(sudo) gmake -f ../Makefile install
'''

### 99. Clean-up

'''Shell
make clean  # cleanup
'''


When compiling, you can choose whether you want to link statically with XML/Ada
(the default), or dynamically. To compile dynamically, you should run:

    $ make LIBRARY_TYPE=relocatable all


# Doc & Examples
==============
[online at AdaCore](http://docs.adacore.com/gprbuild-docs/html/gprbuild_ug.html).

## Prerequisites
=============
TBD
