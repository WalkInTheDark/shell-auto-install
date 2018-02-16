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
        echo "名字：pxe"
        echo
        echo "类型：服务"
        echo
        echo "版本：2.0"
        echo
        echo "作者：book"
        echo
        echo "介绍：pxe一键装机搭建脚本，需要进行一些网段之类的设置"
        echo
        echo "提示：无"
        echo
        echo "使用：pxe命令进去后，选择网卡和镜像就可以部署了"
        echo "      支持kisckstart无人值守，要预先搞好配置文件，这里给出文件位置即可"
    else
        echo "Name：pxe"
        echo
        echo "Type：server"
        echo
        echo "version：2.0"
        echo
        echo "Author：book"
        echo
        echo "Introduction：pxe installed a script installed script, you need to set up some of the network segment"
        echo
        echo "Prompt：none"
        echo
        echo "use：pxe command into it, select the network card and image can be deployed"
        echo "     Support kisckstart unattended, to advance the configuration file, file location can be given here"
    fi
}
