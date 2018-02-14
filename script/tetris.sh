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
        echo "功能：大家熟悉的俄罗斯方块"
        echo
        echo "使用：tetris"
    else
        echo "Function: Everyone is familiar Tetris "
        echo
        echo "use：tetris"
    fi
}
