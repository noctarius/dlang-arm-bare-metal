#!/bin/bash
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Toolchain versions
VERSION_GMP="6.1.0"
VERSION_MPFR="3.1.3"
VERSION_MPC="1.0.3"
VERSION_BINUTILS="2.25"
VERSION_GCC="4.9.3"
VERSION_GDC="4.9"
VERSION_NEWLIB="1.20.0"
VERSION_GDB="7.10"
VERSION_QEMU="2.4.1"

# Names
NAME_GMP="gmp-$VERSION_GMP"
NAME_MPFR="mpfr-$VERSION_MPFR"
NAME_MPC="mpc-$VERSION_MPC"
NAME_BINUTILS="binutils-$VERSION_BINUTILS"
NAME_GCC="gcc-$VERSION_GCC"
NAME_GDC="gdc-$VERSION_GDC"
NAME_NEWLIB="newlib-$VERSION_NEWLIB"
NAME_GDB="gdb-$VERSION_GDB"
NAME_QEMU="qemu-$VERSION_QEMU"

# Compressed file names
TAR_GMP="$NAME_GMP.tar.bz2"
TAR_MPFR="$NAME_MPFR.tar.gz"
TAR_MPC="$NAME_MPC.tar.gz"
TAR_BINUTILS="$NAME_BINUTILS.tar.gz"
TAR_GCC="$NAME_GCC.tar.gz"
TAR_NEWLIB="$NAME_NEWLIB.tar.gz"
TAR_GDB="$NAME_GDB.tar.gz"
TAR_QEMU="$NAME_QEMU.tar.bz2"

# Download source locations
SOURCE_GMP="https://gmplib.org/download/gmp/$TAR_GMP"
SOURCE_MPFR="http://ftp.gnu.org/gnu/mpfr/$TAR_MPFR"
SOURCE_MPC="http://ftp.gnu.org/gnu/mpc/$TAR_MPC"
SOURCE_BINUTILS="http://ftpmirror.gnu.org/binutils/$TAR_BINUTILS"
SOURCE_GCC="http://ftpmirror.gnu.org/gcc/$NAME_GCC/$TAR_GCC"
SOURCE_GDC="https://github.com/D-Programming-GDC/GDC.git"
SOURCE_NEWLIB="ftp://sources.redhat.com/pub/newlib/$TAR_NEWLIB"
SOURCE_GDB="http://ftp.gnu.org/gnu/gdb/$TAR_GDB"
SOURCE_QEMU="http://wiki.qemu-project.org/download/$TAR_QEMU"

# BASE64 encoded diffs
PIXMAN_CONFIGURE_AC="MTEwMywxMTA1YzExMDMKPCAJICAgcGl4bWFuL3BpeG1hbi12ZXJzaW9uLmgKPCAJICAgZGVtb3MvTWFrZWZpbGUKPCAJICAgdGVzdC9NYWtlZmlsZV0pCi0tLQo+IAkgICBwaXhtYW4vcGl4bWFuLXZlcnNpb24uaF0pCg=="
PIXMAN_MAKEFILE_AM="MWMxCjwgU1VCRElSUyA9IHBpeG1hbiBkZW1vcyB0ZXN0Ci0tLQo+IFNVQkRJUlMgPSBwaXhtYW4K"
QEMU_MAKEFILE="MTgxYzE4MQo8IAkkKGNhbGwgcXVpZXQtY29tbWFuZCwkKE1BS0UpICQoU1VCRElSX01BS0VGTEFHUykgLUMgcGl4bWFuIFY9IiQoVikiIGFsbCwpCi0tLQo+IAkkKGNhbGwgcXVpZXQtY29tbWFuZCwkKE1BS0UpICQoU1VCRElSX01BS0VGTEFHUykgLUMgcGl4bWFuIFY9IiQoVikiICxpbnN0YWxsLCkKMTg0YzE4NAo8IAkoY2QgcGl4bWFuOyBDRkxBR1M9IiQoQ0ZMQUdTKSAtZlBJQyAkKGV4dHJhX2NmbGFncykgJChleHRyYV9sZGZsYWdzKSIgJChTUkNfUEFUSCkvcGl4bWFuL2NvbmZpZ3VyZSAkKEFVVE9DT05GX0hPU1QpIC0tZGlzYWJsZS1ndGsgLS1kaXNhYmxlLXNoYXJlZCAtLWVuYWJsZS1zdGF0aWMpCi0tLQo+IAkoY2QgcGl4bWFuOyBDRkxBR1M9IiQoQ0ZMQUdTKSAtZlBJQyAkKGV4dHJhX2NmbGFncykgJChleHRyYV9sZGZsYWdzKSIgJChTUkNfUEFUSCkvcGl4bWFuL2NvbmZpZ3VyZSAkKEFVVE9DT05GX0hPU1QpIC0tZGlzYWJsZS1ndGsgLS1kaXNhYmxlLXNoYXJlZCAtLWVuYWJsZS1zdGF0aWMgLS1kaXNhYmxlLW1teCkK"
PIXMAN_MMX_C="OTJjOTIKPCAjICBpZmRlZiBfX09QVElNSVpFX18KLS0tCj4gIyAgaWYgMAo="

# OS type definitions
OS_TYPE_LINUX="Linux"
OS_TYPE_DARWIN="Darwin"
OS_TYPE_BSD="BSD"
OS_TYPE_WINDOWS="Windows"
OS_TYPE_SOLARIS="Solaris"
OS_TYPE_UNKNOWN="Unknown"

# ARCH type definitions
ARCH_TYPE_X32="x32"
ARCH_TYPE_X64="x64"
ARCH_TYPE_UNKOWN="Unknown"

# Distro type definitions
DISTRO_TYPE_DEBIAN="Debian"
DISTRO_TYPE_SUSE="SuSE"
DISTRO_TYPE_OSX="OSX"
DISTRO_TYPE_REDHAT="RedHat"
DISTRO_TYPE_MANDRAKE="Mandrake"

# APT_GET_UBUNTU_PACKAGES
UBUNTU_PKGS="binutils gcc g++ make autoconf texinfo zlib1g-dev python pkg-config libglib2.0-dev libtool shtool autogen"




#################################################################
# ------------------ DON'T CHANGE BELOW HERE ------------------ #
#################################################################

# Basic setup to have correct toolchain and paths
unset CC
unset CXX

export TARGET="arm-none-eabi"
export PREFIX="$(pwd)/arm-none-eabi"

MY_PWD=$(pwd)
TMP="$MY_PWD/tmp"
DOWNLOAD="$TMP/download"
EXTRACT="$TMP/extract"
BUILD="$TMP/build"
PID="$TMP/pid"
LOG="$TMP/log"

TIMESTAMP=$(date +%Y%m%d%H%M%S)

BUILD_GMP="$BUILD/$NAME_GMP"
BUILD_MPFR="$BUILD/$NAME_MPFR"
BUILD_MPC="$BUILD/$NAME_MPC"
BUILD_BINUTILS="$BUILD/$NAME_BINUTILS"
BUILD_GCC="$BUILD/$NAME_GCC"
BUILD_NEWLIB="$BUILD/$NAME_NEWLIB"
BUILD_GDB="$BUILD/$NAME_GDB"
BUILD_QEMU="$BUILD/$NAME_QEMU"

function init_functions() {
  execute() {
    # Analyze system
    OS_TYPE=$(detect_os_type)
    OS_ARCH=$(detect_os_arch)
    CPUS=$(detect_cpus)
    DISTRO_TYPE=$(detect_distro_type)

    INFO_SIGNAL=$(info_signal)


    echo "Analyzing environment:"
    echo -e "\tOperating System Type: $OS_TYPE"
    echo -e "\tOperating System Architecture: $OS_ARCH"
    echo -e "\tOperating System Distro Like: $DISTRO_TYPE"
    echo -e "\tNumber of physical CPU cores: $CPUS"
    echo

    echo "Checking basic requirements..."
    case $OS_TYPE in
      $OS_TYPE_DARWIN)
        check_os_darwin
        ;;
      $OS_TYPE_LINUX)
        check_os_linux
        ;;
      *)
        echo "The operating system is not yet officially supported. It might work and any help to add additional systems is very appreciated"
        ;;
    esac
    echo

    # Checking prerequisits
    echo "Checking for necessary tools..."
    check_tool python
    check_tool install
    check_tool git
    check_tool curl
    check_tool gcc
    check_tool as
    check_tool ld
    check_tool g++
    check_tool autoconf
    check_tool make
    check_tool automake
    check_tool tar
    check_tool gzip
    check_tool bzip2
    check_tool makeinfo
    check_tool base64
    check_tool patch
    check_tool_os $OS_TYPE_DARWIN clang
    check_tool_os $OS_TYPE_DARWIN xcodebuild "Please install Xcode for full compiler support"
    check_tool_distro $DISTRO_TYPE_DEBIAN apt-get
    check_tool_distro $DISTRO_TYPE_REDHAT yum
    echo

    # Prepare building the toolchain
    echo "Preparing directories..."
    echo -e -n "\tRemove old directories... "

    rm -rf $PID > /dev/null
    rm -rf $EXTRACT > /dev/null
    delete_tool_dir $NAME_BINUTILS
    delete_tool_dir $NAME_GCC
    delete_tool_dir $NAME_NEWLIB
    delete_tool_dir $NAME_GDB
    delete_tool_dir $NAME_QEMU
    echo "success."

    create_dir $PREFIX
    create_dir $DOWNLOAD
    create_dir $PID
    create_dir $LOG
    create_dir $EXTRACT
    create_dir $BUILD
    create_dir $BUILD_BINUTILS
    create_dir $BUILD_GCC
    create_dir $BUILD_NEWLIB
    create_dir $BUILD_GDB
    create_dir $BUILD_QEMU
    echo

    echo "Downloading toolchain sources..."
    download $SOURCE_GMP $TAR_GMP
    download $SOURCE_MPFR $TAR_MPFR
    download $SOURCE_MPC $TAR_MPC
    download $SOURCE_BINUTILS $TAR_BINUTILS
    download $SOURCE_GCC $TAR_GCC
    git_clone $SOURCE_GDC $NAME_GDC
    download $SOURCE_NEWLIB $TAR_NEWLIB
    download $SOURCE_GDB $TAR_GDB
    download $SOURCE_QEMU $TAR_QEMU
    echo

    echo "Extracting sources..."
    decompress $DOWNLOAD $TAR_GMP $EXTRACT
    decompress $DOWNLOAD $TAR_MPFR $EXTRACT
    decompress $DOWNLOAD $TAR_MPC $EXTRACT
    decompress $DOWNLOAD $TAR_BINUTILS $EXTRACT
    decompress $DOWNLOAD $TAR_GCC $EXTRACT
    decompress $DOWNLOAD $TAR_NEWLIB $EXTRACT
    decompress $DOWNLOAD $TAR_GDB $EXTRACT
    decompress $DOWNLOAD $TAR_QEMU $EXTRACT
    echo

    echo -n "Patching GCC sources for GDC... "
    cd $DOWNLOAD/$NAME_GDC
    ./setup-gcc.sh $EXTRACT/$NAME_GCC 1>$LOG/$NAME_GDC.$TIMESTAMP.patching.log 2>&1
    echo "success."
    cd $MY_PWD
    echo

    echo -n "Linking GMP, MPFR, MPC, newlib sources to GCC... "
    symbolic_link $EXTRACT/$NAME_NEWLIB/newlib $EXTRACT/$NAME_GCC/newlib
    symbolic_link $EXTRACT/$NAME_NEWLIB/libgloss $EXTRACT/$NAME_GCC/libgloss
    symbolic_link $EXTRACT/$NAME_GMP $EXTRACT/$NAME_GCC/gmp
    symbolic_link $EXTRACT/$NAME_MPFR $EXTRACT/$NAME_GCC/mpfr
    symbolic_link $EXTRACT/$NAME_MPC $EXTRACT/$NAME_GCC/mpc
    echo "success."
    echo

    guard_os $OS_TYPE_DARWIN patch_qemu_osx

    # Build Binutils
    build $NAME_BINUTILS --target=$TARGET --prefix=$PREFIX --disable-nls --enable-interwork --enable-multilib --disable-werror --with-gnu-as --with-gnu-ld --with-gnu-cc
    export PATH=$PREFIX/bin:$PATH

    # Build GCC
    build_gcc

    # Build GDB
    build $NAME_GDB --target=$TARGET --prefix=$PREFIX --enable-interwork --enable-multilib --disable-werror --enable-target-optspace --enable-sim --disable-nls

    # Build QEMU
    build_qemu $NAME_QEMU --prefix=$PREFIX --target-list=arm-softmmu --disable-cocoa --disable-gtk --disable-vte --disable-xen --disable-xen-pci-passthrough --disable-kvm \
    --disable-libiscsi --disable-libnfs --disable-smartcard-nss --disable-glusterfs --disable-archipelago --disable-tpm --disable-vhdx --disable-numa \
    --disable-guest-agent --disable-guest-agent-msi --disable-brlapi

    echo -n "Cleaning up after compilation... "
    rm -rf $TMP > /dev/null
    check_exit_code "failed. Please remove $TMP directory manually." $?
    echo "success."

    cd $MY_PWD
    echo "Finished."
  }

  patch_qemu_osx() {
    echo -n "Patching QEMU sources for OS X... "
    cd $EXTRACT/$NAME_QEMU
    rm -rf pixman/test
    rm -rf pixman/demos
    apply_diff "$QEMU_MAKEFILE" "$EXTRACT/$NAME_QEMU/Makefile"
    apply_diff "$PIXMAN_MAKEFILE_AM" "$EXTRACT/$NAME_QEMU/pixman/Makefile.am"
    apply_diff "$PIXMAN_CONFIGURE_AC" "$EXTRACT/$NAME_QEMU/pixman/configure.ac"
    apply_diff "$PIXMAN_MMX_C" "$EXTRACT/$NAME_QEMU/pixman/pixman/pixman-mmx.c"
    cd $MY_PWD
    echo "success."
    echo
  }

  check_os_darwin() {
    local success=1
    if [ ! `type -P clang` ]; then
      echo "* Please install Xcode first."
      success=0
    fi
    if [ ! `type -P pkg-config` ] || [ ! `type -P autoconf` ] || [ ! `type -P automake` ]; then
      echo "* Please install necessary tools, this can be easily achieved by using:"
      echo -e "\tMacPorts:"
      echo -e "\t\tDownload and install MacPorts from 'http://www.macports.org/install.php'"
      echo -e "\t\tExecute 'sudo port install pkgconfig'"
      echo "or ..."
      echo -e "\tHomebrew:"
      echo -e "\t\tInstall Homebrew 'ruby -e \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"'"
      echo -e "\t\tExecute 'brew install pkg-config autoconf automake'"
      success=0
    fi
    if [ ! `clang -v 2>&1 | grep "Xcode/iOS" | wc -l | sed -e 's/^[[:space:]]*//'` -eq 0 ]; then
      echo "* Please agree to the license agreement of Xcode by executing 'sudo xcodebuild -license'"
      success=0
    fi
    if [ $success -eq 0 ]; then
      exit 1
    fi
  }

  check_os_linux() {
    case $DISTRO_TYPE in
      $DISTRO_TYPE_DEBIAN)
        if [ `type -P gcc` ]; then
          local success=1
          local pkgs=$(echo $UBUNTU_PKGS | tr " " "/n")
          for pkg in $pkgs; do
            if [ `dpkg -l | grep $pkg | wc -l` -eq 0 ]; then
              success=0
            fi
          done
          if [ $success -eq 0 ]; then
            echo "Not all necessary packages are installed."
            echo "Please execute 'sudo apt-get install $UBUNTU_PKGS'"
            exit 1
          fi
        fi
        ;;
      *)
        echo "The operating system is not yet officially supported. It might work and any help to add additional systems is very appreciated"
        ;;
    esac
  }

  #################################################################
  # -------------------- INTERNAL FUNCTIONS --------------------- #
  #################################################################

  ## download $url $outputfile
  download() {
    echo -e "\tDownload: $2"
    if [ -f $DOWNLOAD/$2 ]; then
      return
    fi
    curl -L --progress-bar $1 -o $DOWNLOAD/$2
  }

  ## check_tool $programmname
  check_tool() {
    echo -en "\tChecking for '$1'... "
    if [ `type -P $1` ]; then
      echo "success."
      return
    else
      echo "failed."
      if [ -n $2 ]; then
        echo ${@:2}
      else
        echo "Tool '$1' is not available, please install it first"
      fi
      exit 1
    fi
  }

  ## check_tool_os $os_type $programmname
  check_tool_os() {
    guard_os $1 check_tool ${@:2}
  }

  ## check_tool_distro $distro $programmname
  check_tool_distro() {
    guard_distro $1 check_tool ${@:2}
  }

  ## guard_distro $distro $call
  guard_distro() {
    guard "[ $DISTRO_TYPE = $1 ]" ${@:2}
  }

  ## guard_os $ostype $call
  guard_os() {
    guard "[ $OS_TYPE = $1 ]" ${@:2}
  }

  ## create_dir $path
  create_dir() {
    echo -en "\tCreating directory '$1'... "
    mkdir -p $1
    echo "success."
  }

  ## progress_bar $max $progress
  progress_bar() {
    local bar="#"
    local width=71
    local percent_width_single=$((width + 3))
    local percent_width_double=$((width + 2))
    local percent_width_tripple=$((width + 1))

    local max=$1
    local count=$2

    local mulplicator=$(echo | awk -v count=$count -v max=$max '{ print count / max }')
    local num_bars=$(echo | awk -v width=$width -v mulplicator=$mulplicator '{ print int(width * mulplicator) }')
    local progress=$(echo | awk -v mulplicator=$mulplicator '{ print (mulplicator * 100) }')

    local progress_bar=""
    for _i in $(seq 0 $num_bars); do progress_bar="${progress_bar}${bar}"; done

    local percent_pos=$percent_width_single
    local t=$(echo | awk -v t=$progress '{ print int(t) }')
    if [ $t -gt 9 -a $t -lt 100 ]; then
      percent_pos=$percent_width_double
    elif [ $t -eq 100 ]; then
      percent_pos=$percent_width_tripple
    fi

    local format=$(echo "\r%-@@@s %.1f%%" | sed -e s/@@@/$percent_pos/)
    printf "$format" $progress_bar $progress
  }

  ## git_clone $url $dirname
  git_clone() {
    local logfile=$LOG/$2.$TIMESTAMP.clone.log
    local dl_dir=$DOWNLOAD/$2

    if [ ! -d $dl_dir ]; then
      mkdir -p $dl_dir
      cd $dl_dir
      git init > /dev/null
      git remote add origin $1 > /dev/null
    else
      cd $dl_dir
      #git reset --hard > /dev/null
    fi

    # Clone repo data
    echo -e "\tCloning: $2..."
    git fetch --progress 1>>$logfile 2>&1 &
    echo $! > $PID/git.pid
    git_wait_with_progress $PID/git.pid $logfile $2

    # Checkout correct branch
    echo -e "\tCheckout: $2..."
    git checkout origin/$2 1>>$logfile 2>&1 &
    echo $! > $PID/git.pid
    git_wait_with_progress $PID/git.pid $logfile $2
  }

  ## git_wait_with_progress $pidfile $logfile $dirname
  git_wait_with_progress() {
    local pid=`cat $1`
    trap "kill $pid 2> /dev/null" EXIT

    git_progress() {
      while kill -0 $1 2> /dev/null; do
        local val=`cat $2 | tail -n1 | grep "[0-9]\{1,3\}%" | sed -n -e 's/.*\ \([0-9]\{1,3\}\)%.*/\1/p'`
        if [ -n val ]; then
          progress_bar 100 $val
        fi
        sleep 0.1
      done
    }
    git_progress $pid $2 &
    local reporter=$!

    wait $pid
    local exitcode=$?

    progress_bar 100 100
    echo
      trap - EXIT
      check_exit_code "failed. Please see $log" $exitcode
    rm $1
  }

  ## is_bz2 $filename
  is_bz2() {
    case $OS_TYPE in
      $OS_TYPE_DARWIN)
        echo $(expr "$tarfile" : '.*bz2$')
        ;;
      *)
        echo $(expr match "$tarfile" '.*bz2$')
        ;;
    esac
  }

  ## decompress $sourcepath $file $outputpath
  decompress() {
    local tarfile=$1/$2
    local logfile=$LOG/$2.$TIMESTAMP.decompress.log
    echo -e "\tExtract: $2"
    local usage=$(ls -la $tarfile | awk '{ print $5 }')
    cd $3

    if [ $(is_bz2 $tarfile) -gt 1 ]; then
      local tarparam="xfj"
    else
      local tarparam="xfz"
    fi

    dd if=$tarfile 2>>$logfile > >(tar $tarparam - 2>&1 1>>$logfile) &
    echo $! > $PID/tar.pid

    tar_wait_with_progress $PID/tar.pid $logfile $usage
    cd $MY_PWD
  }



  ## tar_wait_with_progress $pidfile $logfile $usage
  tar_wait_with_progress() {
    local pid=`cat $1`
    trap "kill $pid 2> /dev/null" EXIT

    tar_progress() {
      while [ ! -f $2 ]; do sleep 0.1; done
      while kill -0 $1 2> /dev/null; do
        kill -SIG${INFO_SIGNAL} $1
        if [ -f $2 ]; then
          if [ $OS_TYPE = $OS_TYPE_LINUX ]; then
            local val=`tail -n2 $2 | grep "copied," | awk '{ print $1 }'`
          else
            #local val=`tail -n2 $2 | grep "In:" | sed -n -e 's/In:\ \([0-9]*\).*/\1/p'`
            local val=`tail -n2 $2 | grep "bytes transferred in" | awk '{ print $1 }'`
          fi
          if [ -n val ]; then
            progress_bar $3 $val
          fi
        fi
        sleep 0.1
      done
    }
    tar_progress $pid $2 $3 &
    local reporter=$!

    wait $pid
    local exitcode=$?

    progress_bar 100 100
    echo
      trap - EXIT
      check_exit_code "failed. Please see $log" $exitcode
      rm $1
  }



  ## configure $toolname $parameters
  configure() {
    local log=$LOG/$1.$TIMESTAMP.configure.log
    echo -e "\t$1 is configured with: ${@:2}"
    echo -e -n "\tExecuting configure... "
    cd $BUILD/$1
    $EXTRACT/$1/configure ${@:2} 1>$log 2>&1
    check_exit_code "failed. Please see $log" $?
    echo "success."
  }

  ## compile $toolname
  compile() {
    local log=$LOG/$1.$TIMESTAMP.compile.log
    echo -e -n "\tCompiling... "
    make ${@:2} -j$CPUS all 1>$log 2>&1
    check_exit_code "failed. Please see $log" $?
    echo "success."
  }

  ## install $toolname $target
  install() {
    local log=$LOG/$1.$TIMESTAMP.install.log
    echo -e -n "\tInstallation... "
    make $2 1>$log 2>&1
    check_exit_code "failed. Please see $log" $?
    echo "success."
  }

  ## build $toolname $parameters
  build() {
    if [ -f $BUILD/$1.success ]; then
      echo "Skip building $1..."
      echo
    else
      echo "Building $1..."
      configure $@
      compile $1
      install $1 install
      touch $BUILD/$1.success
      echo
    fi
  }

  ## build_gcc $parameters
  build_gcc() {
    if [ -f $BUILD_GCC.success ]; then
      echo "Skip building $NAME_GCC..."
      echo
    else
      echo "Building $NAME_GCC..."
      # bootstrapping gcc
      configure $NAME_GCC --target=$TARGET --prefix=$PREFIX --with-cpu=cortex-a8 --with-mode=thumb --enable-languages="c,c++,d" --with-newlib \
      --with-headers=$EXTRACT/$NAME_GCC/newlib/libc/include --with-system-zlib --with-tune=cortex-a8 --with-fpu=neon --with-float=hard --disable-nls \
      --enable-interwork --enable-multilib --disable-werror --enable-target-optspace --with-dwarf2
      compile_gcc all-gcc
      install_gcc install-gcc

      # newlib
      echo -e "\tIntermediate compile of newlib..."
      configure $NAME_NEWLIB --target=$TARGET --prefix=$PREFIX --enable-interwork --enable-multilib --disable-newlib-supplied-syscalls --disable-nls \
      --disable-werror --enable-target-optspace
      compile $NAME_NEWLIB
      install $NAME_NEWLIB

      # second stage GCC
      compile_gcc all
      install_gcc install

      touch $BUILD_GCC.success
      echo
    fi
  }

  ## compile_gcc $target
  compile_gcc() {
    local log=$LOG/$NAME_GCC.$TIMESTAMP.compile.log
    echo -e -n "\tCompiling target $1... "

    local flags="-g -O2"
    if [ $OS_TYPE == $OS_TYPE_DARWIN ]; then
      flags="$flags -fbracket-depth=1024"
    fi

    make CFLAGS="$flags" CXXFLAGS="$flags" -j$CPUS $1 1>>$log 2>&1
    check_exit_code "failed. Please see $log" $?
    echo "success."
  }

  ## install_gcc $target
  install_gcc() {
    local log=$LOG/$NAME_GCC.$TIMESTAMP.install.log
    echo -e -n "\tInstallation target $1... "
    make $1 1>>$log 2>&1
    check_exit_code "failed. Please see $log" $?
    echo "success."
  }

  ## delete_tool_dir $toolname
  delete_tool_dir() {
    if [ ! -f $BUILD/$1.success ]; then
      rm -rf $BUILD/$1 > /dev/null
    fi
  }

  ## build_qemu $toolname $parameters
  build_qemu() {
    if [ -f $BUILD/$1.success ]; then
      echo "Skip building $1..."
      echo
    else
      echo "Building $1..."
      configure $@
      compile $1 -i
      install $1 install
      touch $BUILD/$1.success
      echo
    fi
  }

  ## print $message
  print() {
    echo $1
  }

  ## symbolic_link $source $target
  symbolic_link() {
    ln -s $1 $2
    check_exit_code "failed. Could not create symbolic link to $2" $?
  }

  ## check_exit_code $message $exitcode
  check_exit_code() {
    if [ "$2" -ne 0 ]; then
      print $1
      exit 1
    fi
  }

  detect_os_type() {
    case $(uname -s) in
      Darwin)
        echo $OS_TYPE_DARWIN
        ;;
      Linux)
        echo $OS_TYPE_LINUX
        ;;
      CYGWIN*|MINGW32*|MSYS*)
        echo $OS_TYPE_WINDOWS
        ;;
      *BSD|DragonFly)
        echo $OS_TYPE_BSD
        ;;
      SunOS)
        echo $OS_TYPE_SOLARIS
        ;;
      *)
        echo $OS_TYPE_UNKNOWN;
        ;;
    esac
  }

  detect_os_arch() {
    case $(uname -m) in
      x86_64)
        echo $ARCH_TYPE_X64
        ;;
        i*86|x86_32)
        echo $ARCH_TYPE_X64
        ;;
      *)
        echo $ARCH_TYPE_UNKOWN
        ;;
    esac
  }

  detect_cpus() {
    case $OS_TYPE in
      Darwin)
        echo "$(sysctl -n hw.physicalcpu_max)"
        ;;
      Linux|BSD|Solaris)
        if [ `type -P nproc` ]; then
          echo "$(nproc)"
          return 0
        fi
        echo "$(grep "^core id" /proc/cpuinfo | sort -u | wc -l)"
        ;;
      *)
        # 4 seems a good default for now :)
        echo "4"
        ;;
    esac
  }

  detect_distro_type() {
    case $OS_TYPE in
      Linux)
        # Start with documented ways (http://www.freedesktop.org/software/systemd/man/os-release.html)
        if [ -f /etc/os-release -o -f /usr/lib/os-release ]; then
          local id=$(if test -f /usr/lib/os-release; then source /usr/lib/os-release; fi && source /etc/os-release && if [ -n "$ID_LIKE" ]; then echo $ID_LIKE; else echo $ID; fi | awk '{print tolower($0)}')
          case $id in
            debian|ubuntu|linuxmint)
              echo $DISTRO_TYPE_DEBIAN
              return 0
              ;;
            *redhat*|*fedora*|*rhel*|centos)
              echo $DISTRO_TYPE_REDHAT
              return 0
              ;;
            *suse)
              echo $DISTRO_TYPE_SUSE
              return 0
              ;;
          esac
        fi

        if [ `type -P lsb_release` ]; then
          case $(lsb_release -si | awk '{print tolower($0)}') in
            ubuntu|debian)
              echo $DISTRO_TYPE_DEBIAN
              return 0
              ;;
          esac
        fi

        if [ -f /etc/redhat-release -o -f /etc/centos-release -o -f /etc/fedora-release ]; then
          echo $DISTRO_TYPE_REDHAT
        elif [ -f /etc/SuSE-release -o -f /etc/sles-release ]; then
          echo $DISTRO_TYPE_SUSE
        elif [ -f /etc/mandrake-release ]; then
          echo $DISTRO_TYPE_MANDRAKE
        elif [ -f /etc/debian_version ]; then
          echo $DISTRO_TYPE_DEBIAN
        fi
        ;;
      Darwin)
        echo $DISTRO_TYPE_OSX
        ;;
      BSD)
        echo "$(uname -s)"
        ;;
      *)
        echo "Unknown"
        ;;
    esac
  }

  info_signal() {
    if [ $OS_TYPE == $OS_TYPE_LINUX ]; then
      echo "USR1"
    else
      echo "INFO"
    fi
  }

  ## guard $filter=>"[ $v1 = $v2 ]" $call
  guard() {
    if  eval "$1"; then
      ${@:2}
    fi
  }

  ## apply_diff $base64diff $file
  apply_diff() {
    local tf=$(temp_file)
    echo "$1" | base64 -D > $tf
    patch $2 $tf > /dev/null
    rm $tf
  }

  ## temp_file
  temp_file() {
    if [ `type -P mktemp` ]; then
      echo "$(mktemp)";
    elif [ `type -P tempfile` ]; then
      echo "$(tempfile)"
    else
      while true; do
        local candidate=$(RANDOM);
        if [ ! -f "/tmp/$candidate" ]; then
          echo "/tmp/$candidate"
        fi
      done
    fi
  }
}

# load functions
init_functions
execute
