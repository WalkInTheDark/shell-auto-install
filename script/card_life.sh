#!/usr/bin/env bash



get_card_life() {
    [ $language -eq 1 ] && echo "不用下载" || echo "Do not download"
}

install_card_life() {
    cp conf/alone/card-life /usr/local/bin/card-life
    chmod +x /usr/local/bin/card-life

    echo "card-life" >> conf/installed.txt
    
    clear
    [ $language -eq 1 ] && echo "card-life安装完毕，使用card-life开始游戏" || echo "card-life installation is completed, use card-life Start the game"
}

remove_card_life() {
    rm -rf /usr/local/bin/card-life
    
    [ $language -eq 1 ] && echo "card-life已卸载" || echo "card-life Uninstalled"
}

info_card_life() {
    if [ $language -eq 1 ];then
        echo "名字：card-life

版本：1.4

介绍：抽卡人生

作者：book

提示：将会生成wiki_book.ttt的一个存档，如果想开挂，修改里面数值即可。

使用：card-life进入游戏，输入1-6来购买卡牌"
    else
        echo "Name：card-life
        
version：1.4

Introduction：Card life

Author：book

Prompt：Will generate an archive of wiki_book.ttt, if you want to hang up, you can modify the value inside.

use：card-life into the game, enter 1-6 to buy cards"
    fi
}
