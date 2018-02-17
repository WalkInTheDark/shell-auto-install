#!/usr/bin/env bash

get_snake() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_snake() {
    cp conf/alone/snake /usr/local/bin/snake
    chmod +x /usr/local/bin/snake

    echo "snake" >> conf/installed.txt
    [ $language -eq 1 ] && echo "snake安装完毕，使用snake 开始游戏" || ehco "snake installation is completed, use snake Start the game"
}

remove_snake() {
    rm -rf /usr/local/bin/snake
    [ $language -eq 1 ] && echo "snake已卸载" || ehco "snake Uninstalled"
}


info_snake() {
    if [ $language -eq 1 ];then
        echo "名字：snake
        
类型：游戏

版本：1.0

作者：LingYi

介绍：大家熟知的贪吃蛇

提示：无

使用：snake命令进入游戏，wasd移动来吃点"
    else
        echo "Name：snake
        
Type：game

version：1.0

Author：LingYi

Introduction：We all know the snake

Prompt：none

use：snake command into the game, wasd move to eat"
    fi
}
