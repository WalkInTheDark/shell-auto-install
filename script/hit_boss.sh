#!/usr/bin/env bash



get_hit_boss() {
    [ $language -eq 1 ] && echo "不用下载" || echo "Do not download"
}

install_hit_boss() {
    cp conf/alone/hit-boss /usr/local/bin/hit-boss
    chmod +x /usr/local/bin/hit-boss

    echo "hit-boss" >> conf/installed.txt
    
    clear
    [ $language -eq 1 ] && echo "hit-boss安装完毕，使用hit-boss 开始游戏" || echo "cha installation is completed, use hit-boss  Start the game"
}

remove_hit_boss() {
    rm -rf /usr/local/bin/hit-boss
    
    [ $language -eq 1 ] && echo "hit-boss已卸载" || echo "hit-boss Uninstalled"
}

info_hit_boss() {
    if [ $language -eq 1 ];then
        echo "名字：hit-boss
        
版本：1.2

介绍：回合打boss游戏

作者：book


提示：无

使用：hit-boss命令开始游戏，输入用户名后看游戏介绍"
    else
        echo "Name：hit-boss
        
version：1.2

Introduction：Round play boss game

Author：book

Prompt：none

use：hit-boss command to start the game, enter the user name to see the game introduction"
    fi
}
