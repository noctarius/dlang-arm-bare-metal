#!/bin/bash

# Toolchain versions
VERSION_GMP=6.1.0
VERSION_MPFR=3.1.3
VERSION_MPC=1.0.3
VERSION_BINUTILS=2.25
VERSION_GCC=4.9.3
VERSION_GDC=4.9
VERSION_NEWLIB=1.20.0
VERSION_GDB=7.10

# Names
NAME_GMP=gmp-$VERSION_GMP
NAME_MPFR=mpfr-$VERSION_MPFR
NAME_MPC=mpc-$VERSION_MPC
NAME_BINUTILS=binutils-$VERSION_BINUTILS
NAME_GCC=gcc-$VERSION_GCC
NAME_GDC=gdc-$VERSION_GDC
NAME_NEWLIB=newlib-$VERSION_NEWLIB
NAME_GDB=gdb-$VERSION_GDB

# Compressed file names
TAR_GMP=$NAME_GMP.tar.bz2
TAR_MPFR=$NAME_MPFR.tar.gz
TAR_MPC=$NAME_MPC.tar.gz
TAR_BINUTILS=$NAME_BINUTILS.tar.gz
TAR_GCC=$NAME_GCC.tar.gz
TAR_NEWLIB=$NAME_NEWLIB.tar.gz
TAR_GDB=$NAME_GDB.tar.gz

# Download source locations
SOURCE_GMP=https://gmplib.org/download/gmp/$TAR_GMP
SOURCE_MPFR=http://www.mpfr.org/mpfr-current/$TAR_MPFR
SOURCE_MPC=ftp://ftp.gnu.org/gnu/mpc/$TAR_MPC
SOURCE_BINUTILS=http://ftpmirror.gnu.org/binutils/$TAR_BINUTILS
SOURCE_GCC=http://ftpmirror.gnu.org/gcc/$NAME_GCC/$TAR_GCC
SOURCE_GDC=https://github.com/D-Programming-GDC/GDC.git
SOURCE_NEWLIB=ftp://sources.redhat.com/pub/newlib/$TAR_NEWLIB
SOURCE_GDB=http://ftp.gnu.org/gnu/gdb/$TAR_GDB


#################################################################
# ------------------ DON'T CHANGE BELOW HERE ------------------ #
#################################################################

# Basic setup to have correct toolchain and paths
export TARGET=arm-none-eabi
export PREFIX=$(pwd)/arm-none-eabi

PWD=$(pwd)
TMP=$(pwd)/tmp
DOWNLOAD=$TMP/download
EXTRACT=$TMP/extract
BUILD=$TMP/build
PID=$TMP/pid
LOG=$TMP/log

TIMESTAMP=$(date +%Y%m%d%H%M%S)

BUILD_GMP=$BUILD/$NAME_GMP
BUILD_MPFR=$BUILD/$NAME_MPFR
BUILD_MPC=$BUILD/$NAME_MPC
BUILD_BINUTILS=$BUILD/$NAME_BINUTILS
BUILD_GCC=$BUILD/$NAME_GCC
BUILD_NEWLIB=$BUILD/$NAME_NEWLIB
BUILD_GDB=$BUILD/$NAME_GDB

# Function definitions

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
		echo "Tool '$1' is not available, please install it first"
		exit 1
	fi
}

## create_dir $path
create_dir() {
	echo -en "\tCreating directory '$1'... "
	mkdir -p $1
	echo "success."
}

## progress_bar $max $progress
progress_bar() {
	bar="#"
	width=71
	percent_width_single=$((width + 3))
	percent_width_double=$((width + 2))
	percent_width_tripple=$((width + 1))

    max=$1
    count=$2

    mulplicator=$(echo | awk -v count=$count -v max=$max '{ print count / max }')
    num_bars=$(echo | awk -v width=$width -v mulplicator=$mulplicator '{ print int(width * mulplicator) }')
    progress=$(echo | awk -v mulplicator=$mulplicator '{ print (mulplicator * 100) }')

    progress_bar=""
    for _i in $(seq 0 $num_bars); do progress_bar="${progress_bar}${bar}"; done
    
    percent_pos=$percent_width_single
    t=$(echo | awk -v t=$progress '{ print int(t) }')
    if [ $t -gt 9 -a $t -lt 100 ]; then
	    percent_pos=$percent_width_double
	elif [ $t -eq 100 ]; then
	    percent_pos=$percent_width_tripple
    fi

    format=$(echo "\r%-@@@s %.1f%%" | sed -e s/@@@/$percent_pos/)
    printf "$format" $progress_bar $progress
}

## git_clone $url $dirname
git_clone() {
	dl_dir=$DOWNLOAD/$2

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
	echo -e "\tClone: $2..."
	git fetch --progress 1>$LOG/git.log 2>&1 &
	echo $! > $PID/git.pid
	git_wait_with_progress $PID/git.pid $LOG/git.log

	# Checkout correct branch
	echo -e "\tCheckout: $2..."
	git checkout origin/$2 1>$LOG/git.log 2>&1 &
	echo $! > $PID/git.pid
	git_wait_with_progress $PID/git.pid $LOG/git.log
}

## git_wait_with_progress $pidfile $logfile
git_wait_with_progress() {
	pid=`cat $1`
	trap "kill $pid 2> /dev/null" EXIT
	while kill -0 $pid 2> /dev/null; do
		val=`cat $2 | tail -n1 | grep "[0-9]\{1,3\}%" | sed -n -e 's/.*\ \([0-9]\{1,3\}\)%.*/\1/p'`
		progress_bar 100 $val
		sleep 0.1
	done
	progress_bar 100 100
	echo
    trap - EXIT
    rm $1
    rm $2
}

## decompress $file $outputpath
decompress() {
	echo -e "\tExtract: $1"
	usage=$(ls -la $1 | awk '{ print $5 }')
	cd $2
	if [ $(echo $1 | awk '{ print index($1, "bz2") }') -gt 1 ]; then
		tar xfj $1 1>$LOG/tar.log 2>&1 &
	else
		tar xfz $1 1>$LOG/tar.log 2>&1 &
	fi
	echo $! > $PID/tar.pid
	tar_wait_with_progress $PID/tar.pid $LOG/tar.log $usage
	cd $PWD
}

## tar_wait_with_progress $pidfile $logfile
tar_wait_with_progress() {
	pid=`cat $1`
	trap "kill $pid 2> /dev/null" EXIT
	while kill -0 $pid 2> /dev/null; do
		kill -SIGINFO $pid 
		val=`tail -n2 $2 | grep "In:" | sed -n -e 's/In:\ \([0-9]*\).*/\1/p'`
		progress_bar $3 $val
		sleep 0.2
	done
	progress_bar 100 100
	echo
    trap - EXIT
    rm $1
    rm $2
}

## configure $toolname $parameters
configure() {
	log=$LOG/$1.$TIMESTAMP.configure.log
	echo -e "\$1 is configured with: ${@:2}"
	echo -e -n "\tExecuting configure... "
	cd $BUILD/$1
	$EXTRACT/$1/configure ${@:2} 1>$log 2>&1
	if [ "$?" -ne 0 ]; then
		echo "failed. Please see $log"
		exit 1
	fi
	echo "success."
}

## compile $toolname
compile() {
	log=$LOG/$1.$TIMESTAMP.compile.log
	echo -e -n "\tCompiling... "
	make -j4 all 1>$log 2>&1
	if [ "$?" -ne 0 ]; then
		echo "failed. Please see $log"
		exit 1
	fi
	echo "success."
}

## install $toolname
install() {
	log=$LOG/$1.$TIMESTAMP.install.log
	echo -e -n "\tInstallation... "
	make install 1>$log 2>&1
	if [ "$?" -ne 0 ]; then
		echo "failed. Please see $log"
		exit 1
	fi
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
		install $1
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
	log=$LOG/$NAME_GCC.$TIMESTAMP.compile.log
	echo -e -n "\tCompiling target $1... "
	make CFLAGS="-g -O2 -fbracket-depth=1024" CXXFLAGS="-g -O2 -fbracket-depth=1024" -j4 $1 1>>$log 2>&1
	if [ "$?" -ne 0 ]; then
		echo "failed. Please see $log"
		exit 1
	fi
	echo "success."
}


## install_gcc $target
install_gcc() {
	log=$LOG/$NAME_GCC.$TIMESTAMP.install.log
	echo -e -n "\tInstallation target $1... "
	make $1 1>>$log 2>&1
	if [ "$?" -ne 0 ]; then
		echo "failed. Please see $log"
		exit 1
	fi
	echo "success."
}

## delete_tool_dir $toolname
delete_tool_dir() {
	if [ ! -f $BUILD/$1.success ]; then
		rm -rf $BUILD/$1 > /dev/null
	fi
}



# Checking prerequisits
echo "Checking for necessary tools..."
check_tool git
check_tool curl
check_tool gcc
check_tool tar
check_tool gzip
check_tool bzip2
echo

# Prepare building the toolchain
echo "Preparing directories..."
echo -e -n "\tRemove old directories... "

rm -rf $PID > /dev/null
rm -rf $EXTRACT > /dev/null
delete_tool_dir $NAME_GMP
delete_tool_dir $NAME_MPFR
delete_tool_dir $NAME_MPC
delete_tool_dir $NAME_BINUTILS
delete_tool_dir $NAME_GCC
delete_tool_dir $NAME_NEWLIB
echo "success."
create_dir $PREFIX
create_dir $DOWNLOAD
create_dir $PID
create_dir $LOG
create_dir $EXTRACT
create_dir $BUILD
create_dir $BUILD_GMP
create_dir $BUILD_MPFR
create_dir $BUILD_MPC
create_dir $BUILD_BINUTILS
create_dir $BUILD_GCC
create_dir $BUILD_NEWLIB
create_dir $BUILD_GDB
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
echo

echo "Extracting sources..."
decompress $DOWNLOAD/$TAR_GMP $EXTRACT
decompress $DOWNLOAD/$TAR_MPFR $EXTRACT
decompress $DOWNLOAD/$TAR_MPC $EXTRACT
decompress $DOWNLOAD/$TAR_BINUTILS $EXTRACT
decompress $DOWNLOAD/$TAR_GCC $EXTRACT
decompress $DOWNLOAD/$TAR_NEWLIB $EXTRACT
decompress $DOWNLOAD/$TAR_GDB $EXTRACT
echo

echo -n "Patching GCC sources for GDC... "
cd $DOWNLOAD/$NAME_GDC
./setup-gcc.sh $EXTRACT/$NAME_GCC 1>$LOG/$NAME_GDC.$TIMESTAMP.patching.log 2>&1
echo "success."
cd $PWD
echo

echo -n "Linking GMP, MPFR, MPC, newlib sources to GCC... "
ln -s $EXTRACT/$NAME_NEWLIB/newlib $EXTRACT/$NAME_GCC/newlib
ln -s $EXTRACT/$NAME_NEWLIB/libgloss $EXTRACT/$NAME_GCC/libgloss
ln -s $EXTRACT/$NAME_GMP $EXTRACT/$NAME_GCC/gmp
ln -s $EXTRACT/$NAME_MPFR $EXTRACT/$NAME_GCC/mpfr
ln -s $EXTRACT/$NAME_MPC $EXTRACT/$NAME_GCC/mpc
echo "success."
echo

# Build Binutils
build $NAME_BINUTILS --target=$TARGET --prefix=$PREFIX --disable-nls --enable-interwork --enable-multilib --disable-werror --with-gnu-as --with-gnu-ld --with-gnu-cc
export PATH=$PREFIX/bin:$PATH

# Build GCC
#build_gcc --target=$TARGET --prefix=$PREFIX --enable-languages=d,c,c++ --disable-bootstrap --disable-libssp --disable-libgomp --disable-libmudflap --disable-multilib --disable-libphobos \
#--disable-decimal-float --disable-libffi --disable-libmudflap --disable-libquadmath --disable-libssp --disable-libstdcxx-pch --disable-nls --disable-shared --disable-threads \
#--disable-tls --with-gnu-as --with-gnu-ld --with-gnu-dbg --with-cpu=cortex-a8 --with-tune=cortex-a8 --with-mode=thumb --without-headers --with-gmp=$CC_PREFIX --with-mpfr=$CC_PREFIX --with-mpc=$CC_PREFIX

build_gcc

# Build GDB
build $NAME_GDB --target=$TARGET --prefix=$PREFIX --enable-interwork --enable-multilib --disable-werror --enable-target-optspace

echo "Finished."
