#!/usr/bin/env bash

get_ip_location() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_ip_location() {
    cp conf/alone/ip-location /usr/local/bin/ip-location
    chmod +x /usr/local/bin/ip-location

    echo "ip-location" >> conf/installed.txt
    [ $language -eq 1 ] && echo "ip-location安装完毕，使用ip-location 查询ip所在地" || ehco "ip-location After installation, use ip-location to query the IP address"
}

remove_ip_location() {
    rm -rf /usr/local/bin/ip-location
    [ $language -eq 1 ] && echo "ip-location已卸载" || ehco "ip-location Uninstalled"
}


info_ip_location() {
    if [ $language -eq 1 ];then
        echo "名字：ip-location"
        echo
        echo "类型：系统"
        echo
        echo "版本：1.0"
        echo
        echo "作者：book"
        echo
        echo "介绍：查询当前外网ip所在地"
        echo
        echo "提示：需要可以上外网"
        echo
        echo "使用：ip-location -i 8.8.8.8 来查询这个ip的外网地址"
        echo "      ip-location -q         查询尝试登陆此服务器的ip"
    else
        echo "Name：ip-location"
        echo
        echo "Type：sys"
        echo
        echo "version：1.0"
        echo
        echo "Author：book"
        echo
        echo "Introduction：Query current ip network location"
        echo
        echo "Prompt：Need to be on the Internet"
        echo
        echo "use：ip-location -i 8.8.8.8 to query the IP's external network address"
        echo "     ip-location-q query ip attempt to log in to this server"
    fi
}
