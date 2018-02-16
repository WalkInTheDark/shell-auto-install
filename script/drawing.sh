#!/usr/bin/env bash

get_drawing() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_drawing() {
    cp conf/alone/drawing /usr/local/bin/drawing
    chmod +x /usr/local/bin/drawing

    echo "drawing" >> conf/installed.txt
    [ $language -eq 1 ] && echo "drawing安装完毕，使用drawing 开始游戏" || ehco "cha installation is completed, use drawing Start the game"
}

remove_drawing() {
    rm -rf /usr/local/bin/drawing
    [ $language -eq 1 ] && echo "drawing已卸载" || ehco "drawing Uninstalled"
}


info_drawing() {
    if [ $language -eq 1 ];then
        echo "名字：drawing"
        echo
        echo "类型：游戏"
        echo
        echo "版本：1.0"
        echo
        echo "作者：book"
        echo
        echo "介绍：画图游戏，目前只支持蓝色画笔"
        echo
        echo "提示：将会生成goodboy.txt的一个存档，用来xian-draw脚本读取显示画的图"
        echo
        echo "使用：drawing进入游戏，按空格来切换画笔和橡皮擦，p退出"
    else
        echo "Name：drawing"
        echo
        echo "Type：game"
        echo
        echo "version：1.0"
        echo
        echo "Author：book"
        echo
        echo "Introduction：Drawing games, currently only supports blue brush"
        echo
        echo "Prompt：Will generate a goodboy.txt archive, used to read the xian-draw script draw pictures"
        echo
        echo "use：drawing into the game, press the space bar to switch the brush and eraser, p exit"
    fi
 }
