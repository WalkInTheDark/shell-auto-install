#!/usr/bin/env bash

get_trans() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_trans() {
    cp conf/alone/trans /usr/local/bin/trans
    chmod +x /usr/local/bin/trans

    echo "trans" >> conf/installed.txt
    [ $language -eq 1 ] && echo "trans安装完毕，使用trans 开始翻译" || ehco "trans installation is completed, use trans Start translating"
}

remove_trans() {
    rm -rf /usr/local/bin/trans
    [ $language -eq 1 ] && echo "trans已卸载" || ehco "trans Uninstalled"
}


info_trans() {
    if [ $language -eq 1 ];then
        echo "名字：trans

版本：1.0

作者：liungkejin

介绍：英汉互译

提示：无

使用：trans命令开始翻译"
    else
        echo "Name：trans
        
version：1.0

Author：liungkejin

Introduction：English-Chinese mutual translation

Prompt：none

use：trans Start translating"
    fi
}
