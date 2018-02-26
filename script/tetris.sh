#!/usr/bin/env bash



get_tetris() {
    [ $language -eq 1 ] && echo "不用下载" || echo "Do not download"
}

install_tetris() {
    cp conf/alone/tetris /usr/local/bin/tetris
    chmod +x /usr/local/bin/tetris

    echo "tetris" >> conf/installed.txt
    
    clear
    [ $language -eq 1 ] && echo "tetris安装完毕，使用tetris 开始游戏" || echo "tetris installation is completed, use tetris Start the game"
}

remove_tetris() {
    rm -rf /usr/local/bin/tetris
    
    [ $language -eq 1 ] && echo "tetris 已卸载" || echo "tetris Uninstalled"
}

info_tetris() {
    if [ $language -eq 1 ];then
        echo "名字：tetris
        
版本：1.0

介绍：俄罗斯方块

作者：未知

提示：无

使用：tetris命令进入后即可开始游戏"
    else
        echo "Name：tetris
        
version：1.0

Introduction：Tetris

Author：unknown

Prompt：none

use：tetris command to enter the game to start"
    fi
}
