#!/usr/bin/env bash

get_cha() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_cha() {
    cp conf/alone/cha /usr/local/bin/cha
    chmod +x /usr/local/bin/cha

    echo "cha" >> conf/installed.txt
    [ $language -eq 1 ] && echo "cha安装完毕，使用cha -c 显示中文系统信息" || ehco "cha installation is completed, use cha -c display Chinese system information"
}

remove_cha() {
    rm -rf /usr/local/bin/cha
    [ $language -eq 1 ] && echo "cha已卸载" || ehco "cha Uninstalled"
}


info_cha() {
    if [ $language -eq 1 ];then
        echo "名字：cha
        
版本：1.0

作者：book

介绍：显示系统信息

提示：无

使用：cha命令显示英文系统信息，-c显示中文"
    else
        echo "Name：cha
        
version：1.0

Author：book

Introduction：Display system information

Prompt：none

use：cha command to display English system information, -c display Chinese"
    fi
}
