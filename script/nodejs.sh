#!/usr/bin/env bash



get_nodejs() {
    test_package node-v8.9.3-linux-x64.tar.xz http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/node-v8.9.3-linux-x64.tar.xz

    if [ ! -n "$1" ];then
        [ $language -eq 1 ] && echo "下载完成" || echo "Download completed"
    fi
}

install_nodejs() {
    package=`get_nodejs 1`

    tar -xf package/${package}
    mv node-v8.9.3-linux-x64 /usr/local/nodejs
    
    ln -s /usr/local/nodejs/bin/node /usr/local/bin/node
    ln -s /usr/local/nodejs/bin/npm /usr/local/bin/npm

    echo "nodejs" >> conf/installed.txt
    
    clear
    [ $language -eq 1 ] && echo "nodejs安装完毕，使用node -v 查看版本" || echo "nodejs installation is completed，Use node -v to check the version"
}

remove_nodejs() {
    rm -rf /usr/local/nodejs
    rm -rf /usr/local/bin/node
    rm -rf /usr/local/bin/npm

    [ $language -eq 1 ] && echo "nodejs已卸载" || echo "nodejs Uninstalled"
}


info_nodejs() {
    if [ $language -eq 1 ];then
        echo "名字：nodejs
        
版本：8.9.3

介绍：安装nodejs

作者：book

提示：无

使用：无"
    else
        echo "Name：nodejs
        
version：8.9.3

Introduction：Install nodejs

Author：book

Prompt：none

use：none"
    fi
}
