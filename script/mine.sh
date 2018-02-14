#!/usr/bin/env bash

get_mine() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_mine() {
    cp conf/alone/mine /usr/local/bin/mine
    chmod +x /usr/local/bin/mine

    [ $language -eq 1 ] && echo "mine安装完毕，使用mine 开始游戏" || ehco "mine installation is completed, use mine Start the game"
}

remove_mine() {
    rm -rf /usr/local/bin/mine
    [ $language -eq 1 ] && echo "mine已卸载" || ehco "mine Uninstalled"
}


info_mine() {
    if [ $language -eq 1 ];then
        echo "功能：扫雷游戏"
        echo
        echo "使用：mine"
    else
        echo "Function: Minesweeper game"
        echo
        echo "use：mine"
    fi
}
