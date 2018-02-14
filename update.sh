#!/usr/bin/env bash

load() {
    for i in `ls lib`
    do
        source lib/$i
    done
}
test_install git

test_www www.baidu.com


a=`pwd`
b=`echo ${a##*/}`

ver=`cat conf/version.txt`
new_ver=`https://raw.githubusercontent.com/goodboy23/shell-auto-install/master/conf/version.txt`

if [ ver -lt $new_ver ];then
   cd ..
   tar -cf old.tar.gz $b
   git clone https://github.com/goodboy23/shell-auto-install.git
   [ -d shell-auto-install ] && echo "ok" || echo "error"
else
    echo "ok"
fi
