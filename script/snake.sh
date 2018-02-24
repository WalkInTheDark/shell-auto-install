#!/usr/bin/env bash

get_snake2() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_snake2() {
    cp conf/alone/snake2 /usr/local/bin/snake2
    chmod +x /usr/local/bin/snake2

    echo "snake2" >> conf/installed.txt
    [ $language -eq 1 ] && echo "snake2安装完毕，使用snake2 开始游戏" || ehco "snake2 installation is completed, use snake2 Start the game"
}

remove_snake2() {
    rm -rf /usr/local/bin/snake2
    [ $language -eq 1 ] && echo "snake2已卸载" || ehco "snake2 Uninstalled"
}


info_snake2() {
    if [ $language -eq 1 ];then
        echo "名字：snake
        
版本：1.0

作者：liungkejin

介绍：大家熟知的贪吃蛇

提示：无

使用：snake2命令进入游戏，jkil来吃点"
    else
        echo "Name：snake
        
version：1.0

Author：liungkejin

Introduction：We all know the snake

Prompt：none

use：snake2 command into the game, jkil move to eat"
    fi
}
