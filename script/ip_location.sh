#!/usr/bin/env bash

get_ip_location() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_ip_location() {
    cp conf/alone/ip-location /usr/local/bin/ip-location
    chmod +x /usr/local/bin/ip-location

    [ $language -eq 1 ] && echo "ip-location安装完毕，使用ip-location 查询ip所在地" || ehco "ip-location After installation, use ip-location to query the IP address"
}

remove_ip_location() {
    rm -rf /usr/local/bin/ip-location
    [ $language -eq 1 ] && echo "ip-location已卸载" || ehco "ip-location Uninstalled"
}


info_ip_location() {
    if [ $language -eq 1];then
        echo "功能：查询ip所在地"
        echo
        echo "使用：ip-location -i 8.8.8.8 查询此ip所在地"
    else
        echo "Function: Query ip location"
        echo
        echo "use：ip-location -i 8.8.8.8 Querying the location of this ip"
    fi
}
