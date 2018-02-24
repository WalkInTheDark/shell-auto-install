#!/usr/bin/env bash

get_clock() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_clock() {
    cp conf/alone/clock /usr/local/bin/clock
    chmod +x /usr/local/bin/clock

    echo "clock" >> conf/installed.txt
    [ $language -eq 1 ] && echo "clock安装完毕，使用clock 显示时间" || ehco "clock installation is completed, use clock display time"
}

remove_clock() {
    rm -rf /usr/local/bin/clock
    [ $language -eq 1 ] && echo "clock已卸载" || ehco "clock Uninstalled"
}


info_clock() {
    if [ $language -eq 1 ];then
        echo "名字：clock
        
版本：1.0

作者：liungkejin

介绍：display time

提示：无

使用：clock命令开始游戏"
    else
        echo "Name：clock
        
version：1.0

Author：liungkejin

Introduction：display time

Prompt：none

use：clock command Start the game"
    fi
}
