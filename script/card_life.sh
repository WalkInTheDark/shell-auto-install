#!/usr/bin/env bash

get_card_life() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_card_life() {
    cp conf/alone/card-life /usr/local/bin/card-life
    chmod +x /usr/local/bin/card-life

    [ $language -eq 1 ] && echo "card-life安装完毕，使用card-life 开始游戏" || ehco "card-life installation is completed, use card-life Start the game"
}

remove_card_life() {
    rm -rf /usr/local/bin/card-life
    [ $language -eq 1 ] && echo "card-life已卸载" || ehco "card-life Uninstalled"
}


info_card_life() {
    if [ $language -eq 1 ];then
        echo "名字：card-life"
        echo
        echo "类型：游戏"
        echo
        echo "版本：1.4"
        echo
        echo "作者：book"
        echo
        echo "介绍：抽卡人生shell版本，你被困在地牢里，目标是逃出去"
        echo
        echo "提示：将会生成wiki_book.ttt的一个存档，如果想开挂，修改里面数值即可。"
        echo
        echo "使用：card-life进入游戏，输入1-6来购买卡牌"
    else
        echo "Name：card-life"
        echo
        echo "Type：game"
        echo
        echo "version：1.4"
        echo
        echo "Author：book"
        echo
        echo "Introduction：Shell life shell version, you are trapped in the dungeon, the goal is to escape"
        echo
        echo "Prompt：Will generate an archive of wiki_book.ttt, if you want to hang up, you can modify the value inside."
        echo
        echo "use：card-life into the game, enter 1-6 to buy cards"
    fi

}
