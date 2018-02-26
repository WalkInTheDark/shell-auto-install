#!/usr/bin/env bash



get_gobang() {
    [ $language -eq 1 ] && echo "不用下载" || echo "Do not download"
}

install_gobang() {
    cp conf/alone/gobang /usr/local/bin/gobang
    chmod +x /usr/local/bin/gobang

    echo "gobang" >> conf/installed.txt
    
    clear
    [ $language -eq 1 ] && echo "gobang安装完毕，使用gobang开始游戏" || echo "gobang installation is completed, use gobang Start the game"
}

remove_gobang() {
    rm -rf /usr/local/bin/gobang
    
    [ $language -eq 1 ] && echo "gobang已卸载" || echo "gobang Uninstalled"
}

info_gobang() {
    if [ $language -eq 1 ];then
        echo "名字：gobang
        
版本：1.0

介绍：五子棋

作者：yinyuemi

提示：人机博弈需要等一段时间，机器需要反应

使用：gobang进入游戏，按1选择人对人，按2选择人机博弈
     jikl移动，空格确定，b返回首页，q退出"
    else
        echo "Name：gobang
        
version：1.0

Introduction：Gobang

Author：yinyuemi

Prompt：Man-machine game needs to wait for a period of time, the machine needs to respond

use：Gobang into the game, press 1 to select people, press 2 to select man-machine game
     jikl move, spaces to determine, b back to the home page, q exit"
    fi
}
