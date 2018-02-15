#!/usr/bin/env bash

get_pxe() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_pxe() {
    cp conf/alone/pxe /usr/local/bin/pxe
    chmod +x /usr/local/bin/pxe

    [ $language -eq 1 ] && echo "pxe安装完毕，使用pxe 开始安装服务，交互" || ehco "pxe installation is completed, Use pxe to start the installation service, interactive"
}

remove_pxe() {
    rm -rf /usr/local/bin/pxe
    
    [ $language -eq 1 ] && echo "pxe已卸载" || ehco "pxe Uninstalled"
}


info_pxe() {
    if [ $language -eq 1 ];then
        echo "功能：pxe一键装机，交互"
        echo
        echo "使用：pxe"
    else
        echo "Function: pxe a key installed, interactive"
        echo
        echo "use：pxe"
    fi
}
