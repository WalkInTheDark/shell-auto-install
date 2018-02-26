#!/usr/bin/env bash



get_mine() {
    [ $language -eq 1 ] && echo "不用下载" || echo "Do not download"
}

install_mine() {
    cp conf/alone/mine /usr/local/bin/mine
    chmod +x /usr/local/bin/mine

    echo "mine" >> conf/installed.txt
    
    clear
    [ $language -eq 1 ] && echo "mine安装完毕，使用mine 开始游戏" || echo "mine installation is completed, use mine Start the game"
}

remove_mine() {
    rm -rf /usr/local/bin/mine
    
    [ $language -eq 1 ] && echo "mine已卸载" || echo "mine Uninstalled"
}

info_mine() {
    if [ $language -eq 1 ];then
        echo "名字：mine
       
版本：1.0

介绍：扫雷小游戏

作者：未知

提示：无

使用：mine命令进入后，1-3来选择难度，4退出
     wasd移动，j挖，f放旗子，n返回上一级，x退出"
    else
        echo "Name：mine
       
version：1.0

Introduction：minesweeper game

Author：unknown

Prompt：none

use：mine command to enter, 1-3 to choose the difficulty, 4 exit
     wasd move, j dig, f put flag, n return to the previous level, x exit"
    fi
}
