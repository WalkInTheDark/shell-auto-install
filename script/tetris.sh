#!/usr/bin/env bash
#俄罗斯方块，代码写的很工整
#小游戏也写的很棒


get_tetris() {
    test_package https://raw.githubusercontent.com/goodboy23/shell-script/master/script/tetris
}

install_tetris() {
    get_tetris
    cp conf/alone/tetris /usr/local/bin/tetris
    chmod +x /usr/local/bin/tetris

    clear
    echo "install ok

dir=/usr/local/bin/tetris

tetris installation is completed, use tetris Start the game"
}

info_tetris() {
    echo "Name：tetris
        
version：1.0

Introduction：俄罗斯方块"
}
