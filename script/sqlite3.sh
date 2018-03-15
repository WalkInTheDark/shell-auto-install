#!/usr/bin/env bash



get_sqlite3() {
    test_package http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/sqlite-snapshot-201803072139.tar.gz b2447f8009fba42eabaeef6fcf208e2c
}

install_sqlite3() {
    #检测目录
    test_dir $sqlite3_dir
    test_install gcc cmake
    
    #安装服务
    get_sqlite3
    tar -xf package/sqlite-snapshot-201803072139.tar.gz
    cd sqlite-snapshot-201803072139
    ./configure --prefix=${install_dir}/${sqlite3_dir}
    make && make install
    
    #测试
    sqlite3 -version
    [ $? -eq 0 ] || test_exit "Installation error, please check the script"

    clear
        echo "install ok

install_dir=${install_dir}/${sqlite3_dir}"
}

info_sqlite3() {
    echo "Name：sqlite3
        
version：3.23.0

Introduction：安装sqlite3"
}
