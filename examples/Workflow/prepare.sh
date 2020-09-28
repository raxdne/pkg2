#
#
#

export CXP_LOG=2
export CXP_PATH=../..//
export LANG=
#export LANG=en
export TMPDIR=`pwd`/tmp

test -d $TMPDIR || mkdir -p $TMPDIR
# 
~/cxproc-build/x86_64-gnu-linux-debug/bin/cxproc PkgProcessMain.cxp workflow.pie 2> $TMPDIR/main.log

