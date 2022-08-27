# `gprbuild` from AdaCore

This fork is a (slight) rework of the installation scripts and process as to build 
the software on exotic(!) OS systems as `macOS` & `FreeBSD`.

Aim is to have a working bootstrap on those plateforms.

Brought to you by [AdaForge](https://www.Adaforge.org).

All merits go to [Adacore](https://www.Adacore.com)'s Team.

### Major diffs with AdaCore's version

* up to date info about version #, date and year
* all build artefacts will lay in an dedicated  build directory
* corrected some gcc compiler switch typos in `*.gpr` files (`-gnat2022`)
* clean-up `.gitignore` file

## Prerequisites

* Ada compiler. I use `gcc` (from GNU FSF)
* [gprconfig_kb](https://github.com/AdaCore/gprconfigure_kb)
* [xmlada](https://github.com/AdaCore/xmlada)


## Configuration as code

* `DESTDIR` / `PREFIX` : I personnaly install exprimental dev-tools in my `/home` - `/Users` directory
  *   typicaly on FreeBSD : `/home/william/usr/local`
  *   typicaly on macOS : `/Users/william/Library/Developer/GNAT`
* `gprconfig_kb` and `xmlada` are located at the same level as `gprbuild`
* Build directory is a sub-directory of the gprbuild project’ named `build`
* `GPR_PROJECT_PATH` is not set’ and defaults in my case to 
   * on FreeBSD : `/home/william/usr/local/share/gpr`
   * on macOS : `/Users/william/Library/Developer/GNAT/share/gpr`


## Environment variables

`DESTDIR=`your installation location WITH a TRAILING slash '/'; defaults to `/usr/local`
export ADA_PROJECT_PATH=..
unset PRJ_PROJECT_PATH

Optional
`CC=`(...your C/Ada compiler)
`CXX=`(...your C++ compiler)
`GNATMAKE=`(...your C/Ada compiler)


When compiling, you can choose whether you want to link statically with XML/Ada
(the default), or dynamically. To compile dynamically, you should run:

```Shell
gmake LIBRARY_TYPE=relocatable all
```

### Sample

* on FreeBSD

```Shell
export ADA_PROJECT_PATH=..
unset PRJ_PROJECT_PATH
export DESTDIR=/users/william/
export CC=/home/william/usr/local/gcc-12.2.0/bin/gcc
export CXX=/home/william/usr/local/gcc-12.2.0/bin/g++
export GNATMAKE=/home/william/usr/local/gcc-12.2.0/bin/gnatmake
```

* on MacOS

```Shell
export ADA_PROJECT_PATH=..
unset PRJ_PROJECT_PATH
export DESTDIR=/Users/william/Library/Developer/
PREFIX=GNAT
export CC=/Users/william/Library/Developer/GNAT/gcc-12.2.0/bin/gcc
export CXX=/Users/william/Library/Developer/GNAT/gcc-12.2.0/bin/g++
export GNATMAKE=/Users/william/Library/Developer/GNAT/gcc-12.2.0/bin/gnatmake
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

From [Adaforge.org](https://www.Adaforge.org)'s [GitHub repository](https://github.com/AdaForge)

```Shell
git pull https://github.com/AdaForge/gprbuild.git 
git pull https://github.com/AdaForge/gprconfigure_kb.git 
git pull https://github.com/AdaForge/xmlada.git 
```

### `0.b` Set environment variables

```Shell
export ADA_PROJECT_PATH=..
unset PRJ_PROJECT_PATH
export DESTDIR=/.../
```

* optional

```Shell
export CC=/.../bin/gcc
export CXX=/.../bin/g++
export GNATMAKE=/.../bin/gnatmake
```

### `1.` Build a first temporary `gprbuild` (ligth) = Bootstrap

```Shell
cd gprbuild
mkdir -p build
cd build
../bootstrap.sh --with-xmlada=../../xmlada --with-kb=../../gprconfig_kb --prefix=./bootstrap --srcdir=.. --build
(sudo) ../bootstrap.sh --prefix=./bootstrap --srcdir=.. --install
```

* short form
```Shell
mkdir -p gprbuild/build
cd gprbuild/build
../bootstrap.sh  --build
(sudo) ../bootstrap.sh  --prefix=/.../ --install
```

### `2.` Build  `xmlada`

* you are in `.../xmlada/build`. or `.../xmlada.git/build`
```Shell
../configure --prefix=/.../
gmake all
(sudo) gmake install
```

### `2.` Prepare build = Configure the `Makefile`

* you are in `.../gprbuild/build`
```Shell
gmake -f ../Makefile prefix=/Library/Developer/GNAT SOURCE_DIR=.. ENABLE_SHARED=no setup
```

### `3.` Launch the build of the full `gprbuild`

* you are in `.../gprbuild/build`
```Shell
export ADA_PROJECT_PATH=..:/Library/Developer/GNAT/share/gpr
gmake -f ../Makefile all
(sudo) gmake -f ../Makefile install
```

### `99.` Clean-up

* you are in `.../gprbuild/build`

```Shell
cd ..
gmake clean
```
or more straightforward:
```Shell
cd ..
rm -r build
```

# Doc & Examples

[online at AdaCore](http://docs.adacore.com/gprbuild-docs/html/gprbuild_ug.html).

## Prerequisites

In order to build the docs, you need to have the following tools installed:

* `sphinx` -> `pip install sphinx`
* `latexmk`and `texlive-latex-extra`  
  * [macOS] -> `sudo port install latexmk texlive-latex-extra `
  * [FreeBSD] -> `sudo pkg install latexmk texlive-latex-extra `
* [gsftopk](https://math.berkeley.edu/~vojta/gsftopk.html)

## updating LaTex environment

```Shell
sudo texhash
```

### Style defs

    * [TeX Gyre Termes](https://www.gust.org.pl/projects/e-foundry/tex-gyre/termes/index_html)
    * [TeX Gyre Heros](https://www.gust.org.pl/projects/e-foundry/tex-gyre/heros)
    * [sphinxmulticell.sty](https://github.com/Crashedmind/PlantUMLHitchhikersGuide/blob/master/sphinxmulticell.sty)
    * [footnotehyper-sphinx.sty](https://github.com/Crashedmind/PlantUMLHitchhikersGuide/blob/master/sphinxmulticell.sty)

### Fonts

* /opt/local/share/texmf-texlive/fonts/tfm/public/tex-gyre/ec-qhvbi.tfm
