#!/usr/bin/env bash

get_cha() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_cha() {
    cp conf/alone/cha /usr/local/bin/cha
    chmod +x /usr/local/bin/cha

    [ $language -eq 1 ] && echo "cha安装完毕，使用cha -c 显示中文系统信息" || ehco "cha installation is completed, use cha -c display Chinese system information"
}

remove_cha() {
    rm -rf /usr/local/bin/cha
    [ $language -eq 1 ] && echo "cha已卸载" || ehco "cha Uninstalled"
}


info_cha() {
    if [ $language -eq 1];then
        echo "功能：显示系统信息"
        echo
        echo "使用：cha"
    else
        echo "Function: Display system information"
        echo
        echo "use：cha"
    fi
}
