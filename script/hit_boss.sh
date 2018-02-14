#!/usr/bin/env bash

get_hit_boss() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_hit_boss() {
    cp conf/alone/hit-boss /usr/local/bin/hit-boss
    chmod +x /usr/local/bin/hit-boss

    [ $language -eq 1 ] && echo "hit-boss安装完毕，使用hit-boss 开始游戏" || ehco "cha installation is completed, use hit-boss  Start the game"
}

remove_hit_boss() {
    rm -rf /usr/local/bin/hit-boss
    [ $language -eq 1 ] && echo "hit-boss已卸载" || ehco "hit-boss Uninstalled"
}


info_hit_boss() {
    if [ $language -eq 1];then
        echo "功能：魔兽风格，回合制打boos游戏"
        echo
        echo "使用：hit-boss"
    else
        echo "Function: Warcraft style, turn-based playing boos game"
        echo
        echo "use：hit-boss"
    fi
}
