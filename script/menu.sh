get_menu() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_menu() {
    cp conf/alone/menu /usr/local/bin/menu
    chmod +x /usr/local/bin/menu

    [ $language -eq 1 ] && echo "menu安装完毕，使用menu 开始游戏" || ehco "menu installation is completed, use menu Start the game"
}

remove_menu() {
    rm -rf /usr/local/bin/menu
    [ $language -eq 1 ] && echo "menu已卸载" || ehco "menu Uninstalled"
}


info_mine() {
    if [ $language -eq 1 ];then
        echo "功能：显示一个表格，可用上下键来移动"
        echo
        echo "使用：menu"
    else
        echo "Function: Display a table, use the up and down keys to move"
        echo
        echo "use：menu"
    fi
}
