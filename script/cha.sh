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
        echo "名字：cha"
        echo
        echo "类型：系统"
        echo
        echo "版本：1.0"
        echo
        echo "作者：book"
        echo
        echo "介绍：显示系统信息"
        echo
        echo "提示：无"
        echo
        echo "使用：cha命令显示英文系统信息，-c显示中文"
    else
        echo "Name：cha"
        echo
        echo "Type：sys"
        echo
        echo "version：1.0"
        echo
        echo "Author：book"
        echo
        echo "Introduction：Display system information"
        echo
        echo "Prompt：none"
        echo
        echo "use：cha command to display English system information, -c display Chinese"

    fi
}
