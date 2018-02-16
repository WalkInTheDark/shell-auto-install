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
        echo "名字：ip-location
类型：系统
版本：1.0
作者：book
介绍：查询当前外网ip所在地
提示：需要可以上外网
使用：ip-location -i 8.8.8.8 来查询这个ip的外网地址
      ip-location -q         查询尝试登陆此服务器的ip"
    else
        echo "Name：ip-location
Type：sys
version：1.0
Author：book
Introduction：Query current ip network location
Prompt：Need to be on the Internet
use：ip-location -i 8.8.8.8 to query the IP's external network address
     ip-location-q query ip attempt to log in to this server"
    fi
}
