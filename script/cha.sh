#!/usr/bin/env bash
#可以查询系统的相关信息罗列出来
#不满意或精简，请修改脚本


get_cha() {
    test_package https://raw.githubusercontent.com/goodboy23/shell-script/master/script/cha
}

install_cha() {
    get_cha
    command=/usr/local/bin/cha
    rm -rf $command
    cp package/cha $command
    chmod +x $command

    clear
    echo "install ok
    
install_dir=/usr/local/bin/cha
    
Start：cha -c"
}

info_cha() {
    echo "Name：cha
        
version：1.0

Introduction：查看系统信息"
}
