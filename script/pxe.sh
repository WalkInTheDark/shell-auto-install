#!/usr/bin/env bash

get_pxe() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_pxe() {
    cp conf/alone/pxe /usr/local/bin/pxe
    chmod +x /usr/local/bin/pxe
    
    echo "pxe" >> conf/installed.txt
    [ $language -eq 1 ] && echo "pxe安装完毕，使用pxe 开始安装服务，交互" || ehco "pxe installation is completed, Use pxe to start the installation service, interactive"
}

remove_pxe() {
    rm -rf /usr/local/bin/pxe
    
    [ $language -eq 1 ] && echo "pxe已卸载" || ehco "pxe Uninstalled"
}


info_pxe() {
    if [ $language -eq 1 ];then
        echo "名字：pxe
        
类型：服务

版本：2.0

作者：book

介绍：pxe一键装机搭建脚本，需要进行一些网段之类的设置

提示：无

使用：pxe命令进去后，选择网卡和镜像就可以部署了
     支持kisckstart无人值守，要预先搞好配置文件，这里给出文件位置即可"
    else
        echo "Name：pxe
        
Type：server

version：2.0

Author：book

Introduction：pxe installed a script installed script, you need to set up some of the network segment

Prompt：none

use：pxe command into it, select the network card and image can be deployed
     Support kisckstart unattended, to advance the configuration file, file location can be given here"
    fi
}
