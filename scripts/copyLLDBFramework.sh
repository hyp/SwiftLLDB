#!/bin/sh

path=${BUILT_PRODUCTS_DIR}/externalFrameworks/
mkdir -p ${path}
sync

rm -rf ${path}/LLDB.framework
if [ "Release" = "${CONFIGURATION}" ]; then
    cp -a ${SRCROOT}/../build/Ninja-ReleaseAssert/lldb-macosx-x86_64/CustomSwift-Release/LLDB.framework ${path}
else
    cp -a ${SRCROOT}/../build/Ninja-DebugAssert/lldb-macosx-x86_64/CustomSwift-Debug/LLDB.framework ${path}
fi
