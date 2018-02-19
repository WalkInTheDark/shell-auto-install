#!/usr/bin/env bash

get_tetris() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_tetris() {
    cp conf/alone/tetris /usr/local/bin/tetris
    chmod +x /usr/local/bin/tetris

    echo "tetris" >> conf/installed.txt
    [ $language -eq 1 ] && echo "tetris安装完毕，使用tetris 开始游戏" || ehco "tetris installation is completed, use tetris Start the game"
}

remove_tetris() {
    rm -rf /usr/local/bin/tetris
    [ $language -eq 1 ] && echo "tetris 已卸载" || ehco "tetris Uninstalled"
}


info_tetris() {
    if [ $language -eq 1 ];then
        echo "名字：tetris
        
版本：1.0

作者：未知

介绍：大家熟悉的俄罗斯方块

提示：无

使用：tetris命令进入后即可开始游戏"
    else
        echo "Name：tetris
        
version：1.0

Author：unknown

Introduction：Everyone is familiar Tetris

Prompt：none

use：tetris command to enter the game to start"
    fi
}
