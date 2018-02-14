#!/usr/bin/env bash

get_drawing() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_drawing() {
    cp conf/alone/drawing /usr/local/bin/drawing
    chmod +x /usr/local/bin/drawing

    [ $language -eq 1 ] && echo "drawing安装完毕，使用drawing 开始游戏" || ehco "cha installation is completed, use drawing Start the game"
}

remove_drawing() {
    rm -rf /usr/local/bin/drawing
    [ $language -eq 1 ] && echo "drawing已卸载" || ehco "drawing Uninstalled"
}


info_drawing() {
    if [ $language -eq 1];then
        echo "功能：画图"
        echo
        echo "使用：drawing"
    else
        echo "Function: Drawing"
        echo
        echo "use：drawing"
    fi
}
