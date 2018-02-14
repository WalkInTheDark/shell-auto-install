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
    if [ $language -eq 1];then
        echo "功能：抽卡人生shell版本，你被困在地牢里，目标是逃出去"
        echo
        echo "使用：card-life"
    else
        echo "Function: Shell life shell version, you are trapped in the dungeon, the goal is to escape"
        echo
        echo "use：card-life"
    fi
}
