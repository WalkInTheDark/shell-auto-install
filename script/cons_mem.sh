get_cons_mem() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_cons_mem() {
    cp conf/alone/cons_mem /usr/local/bin/cons_mem
    chmod +x /usr/local/bin/cons_mem

    [ $language -eq 1 ] && echo "cons-mem安装完毕，使用cons-mem 开始游戏" || ehco "cons-mem installation is completed, use cons-mem Start the game"
}

remove_cons_mem() {
    rm -rf /usr/local/bin/cons_mem
    [ $language -eq 1 ] && echo "cons-mem已卸载" || ehco "cons-mem Uninstalled"
}


info_cons_mem() {
    if [ $language -eq 1 ];then
        echo "功能：监控或消耗内存资源，　指定需要消耗到的百分比"
        echo
        echo "使用：cons-mem"
        echo
        echo "直接回车，查看当前内存的百分比，或者输入欲消耗的内存百分比"
    else
        echo "Function: Monitor or consume memory resources, specifying the percentage that needs to be consumed"
        echo
        echo "use：cons-mem"
        echo
        echo "Enter directly to see the current percentage of memory, or enter the percentage of memory you want to consume"
    fi
}
