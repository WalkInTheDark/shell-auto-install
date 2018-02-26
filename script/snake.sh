#!/usr/bin/env bash



get_snake() {
    [ $language -eq 1 ] && echo "不用下载" || echo "Do not download"
}

install_snake() {
    cp conf/alone/snake /usr/local/bin/snake
    chmod +x /usr/local/bin/snake

    echo "snake" >> conf/installed.txt
    
    clear
    [ $language -eq 1 ] && echo "snake安装完毕，使用snake开始游戏" || echo "snake installation is completed, use snake Start the game"
}

remove_snake() {
    rm -rf /usr/local/bin/snake
    
    [ $language -eq 1 ] && echo "snake已卸载" || echo "snake Uninstalled"
}

info_snake() {
    if [ $language -eq 1 ];then
        echo "名字：snake
        
版本：1.0

介绍：贪吃蛇

作者：liungkejin

提示：无

使用：snake命令进入游戏，jkil来吃点"
    else
        echo "Name：snake
        
version：1.0

Introduction：snake

Author：liungkejin

Prompt：none

use：snake command into the game, jkil move to eat"
    fi
}
