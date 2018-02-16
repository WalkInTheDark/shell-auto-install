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


info_menu() {
   if [ $language -eq 1 ];then
        echo "名字：menu"
        echo
        echo "类型：游戏"
        echo
        echo "版本：1.0"
        echo
        echo "作者：LingYi"
        echo
        echo "介绍：显示一个表格，可用上下键来移动"
        echo
        echo "提示：无"
        echo
        echo "使用：menu命令开始游戏"
    else
        echo "Name：menu"
        echo
        echo "Type：game"
        echo
        echo "version：1.0"
        echo
        echo "Author：LingYi"
        echo
        echo "Introduction：Display a table, use the up and down keys to move"
        echo
        echo "Prompt：none"
        echo
        echo "use：menu command to start the game"
    fi
}
