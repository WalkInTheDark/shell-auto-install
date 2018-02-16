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
        echo "名字：mine"
        echo
        echo "类型：游戏"
        echo
        echo "版本：1.0"
        echo
        echo "作者：未知"
        echo
        echo "介绍：扫雷小游戏，可以选择难度。"
        echo
        echo "提示：无"
        echo
        echo "使用：mine命令进入后，1-3来选择难度，4退出"
        echo "      wasd移动，j挖，f放旗子，n返回上一级，x退出"
    else
        echo "Name：mine"
        echo
        echo "Type：game"
        echo
        echo "version：1.0"
        echo
        echo "Author：unknown"
        echo
        echo "Introduction：minesweeper game, you can choose the difficulty."
        echo
        echo "Prompt：none"
        echo
        echo "use：mine command to enter, 1-3 to choose the difficulty, 4 exit"
        echo "     wasd move, j dig, f put flag, n return to the previous level, x exit"
    fi
}
