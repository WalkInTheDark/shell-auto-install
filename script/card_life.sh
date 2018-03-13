#!/usr/bin/env bash
#抽卡人生小游戏，当前最快47天通关。
#启动将生成一个存档，不建议改存档。
#攻略：最好是过天数，不花任何法力买卡牌，然后10连抽



get_card_life() {
    test_package "https://raw.githubusercontent.com/goodboy23/shell-script/master/script/card-life"
}

install_card_life() {
    get_card_life
    command=/usr/local/bin/card-life
    rm -rf $command
    cp package/card-life $command
    chmod +x $command

    clear
    echo "install ok
    
install_dir=/usr/local/bin/card-life

Start：card-life"
}

info_card_life() {
        echo "Name：card-life

Version：1.4

Introduce：抽卡人生"
}
