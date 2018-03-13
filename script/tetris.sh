#!/usr/bin/env bash
#俄罗斯方块，代码写的很工整
#小游戏也写的很棒


get_tetris() {
    test_package https://raw.githubusercontent.com/goodboy23/shell-script/master/script/tetris
}

install_tetris() {
    get_tetris
    command=/usr/local/bin/tetris
    rm -rf $command
    cp conf/alone/tetris $command
    chmod +x $command

    clear
    echo "install ok

dir=/usr/local/bin/tetris

Start：tetris"
}

info_tetris() {
    echo "Name：tetris
        
version：1.0

Introduction：俄罗斯方块"
}
