#!/usr/bin/env bash

get_tetris() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_tetris() {
    cp conf/alone/tetris /usr/local/bin/tetris
    chmod +x /usr/local/bin/tetris

    [ $language -eq 1 ] && echo "tetris安装完毕，使用tetris 开始游戏" || ehco "tetris installation is completed, use tetris Start the game"
}

remove_tetris() {
    rm -rf /usr/local/bin/tetris
    [ $language -eq 1 ] && echo "tetris 已卸载" || ehco "tetris Uninstalled"
}


info_tetris() {
    if [ $language -eq 1 ];then
        echo "名字：tetris"
        echo
        echo "类型：游戏"
        echo
        echo "版本：1.0"
        echo
        echo "作者：未知"
        echo
        echo "介绍：大家熟悉的俄罗斯方块"
        echo
        echo "提示：无"
        echo
        echo "使用：tetris命令进入后即可开始游戏"
    else
        echo "Name：tetris"
        echo
        echo "Type：game"
        echo
        echo "version：1.0"
        echo
        echo "Author：unknown"
        echo
        echo "Introduction：Everyone is familiar Tetris"
        echo
        echo "Prompt：none"
        echo
        echo "use：tetris command to enter the game to start"
    fi
}
