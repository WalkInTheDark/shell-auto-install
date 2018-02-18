#!/usr/bin/env bash

get_nodejs() {
    test_package node-v8.9.3-linux-x64.tar.xz http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/node-v8.9.3-linux-x64.tar.xz 32948a8ca5e6a7b69c03ec1a23b16cd2
    if [ $language -eq 1 ];then
        echo "node-v8.9.3-linux-x64.tar.xz 下载完成"
    else
        echo "node-v8.9.3-linux-x64.tar.xz Download completed"
    fi    
}

install_nodejs() {
    get_nodejs

    tar -xf server/nodejs/node-v8.9.3-linux-x64.tar.xz
    mv node-v8.9.3-linux-x64 /usr/local/nodejs
    
    ln -s /usr/local/nodejs/bin/node /usr/local/bin/node
    ln -s /usr/local/nodejs/bin/npm /usr/local/bin/npm

    echo "nodejs" >> conf/installed.txt
    [ $language -eq 1 ] && echo "nodejs安装完毕，使用node -v 查看版本" || ehco "nodejs installation is completed，Use node -v to check the version"
}

remove_nodejs() {
    rm -rf /usr/local/nodejs
    rm -rf /usr/local/bin/node
    rm -rf /usr/local/bin/npm

    [ $language -eq 1 ] && echo "nodejs已卸载" || ehco "nodejs Uninstalled"
}


info_nodejs() {
    if [ $language -eq 1 ];then
        echo "名字：nodejs
        
类型：语言

版本：8.9.3

作者：book

介绍：安装nodejs

提示：无

使用：无"
    else
        echo "Name：nodejs
        
Type：lang

version：8.9.3

Author：book

Introduction：Install nodejs

Prompt：none

use：none"
    fi
}
