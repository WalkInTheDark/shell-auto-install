#!/usr/bin/env bash
#抽卡人生小游戏，当前最快47天通关。
#启动将生成一个存档，不建议改存档。
#攻略：最好是过天数，不花任何法力买卡牌，然后10连抽



get_card_life() {
    test_package "https://raw.githubusercontent.com/goodboy23/shell-script/master/script/card-life"
}

install_card_life() {
    get_card_life
    cp package/card-life /usr/local/bin/card-life
    chmod +x /usr/local/bin/card-life

    clear
    echo "install ok
    
dir=/usr/local/bin/card-life

card-life starts the game"
}

info_card_life() {
        echo "Name：card-life

Version：1.4

Introduce：抽卡人生"
}
