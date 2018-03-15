#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#服务目录名
glibc_dir=glibc-2.14



get_glibc() {
    test_package http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/glibc-2.14.tar.gz 4657de6717293806442f4fdf72be821b
}

install_glibc() {
    #检测目录
    test_dir $glibc_dir
    test_install gcc cmake
    
    #安装服务
    get_glibc
    tar -xf package/glibc-2.14.tar.gz
    cd glibc-2.14
    mkdir build
    cd build
    ../configure --prefix=${install_dir}/${glibc_dir}
    make && make install
    cd ..
    cd ..
    rm -rf glibc-2.14
    
    #清除软连接
    rm -rf /lib64/libc.so.6
    ln -s /opt/glibc-2.14/lib/libc-2.14.so /lib64/libc.so.6

    clear
        echo "install ok

install_dir=${install_dir}/${glibc_dir}

bin=/lib64/libc.so.6"
}

info_glibc() {
    echo "Name：glibc
        
version：2.14

Introduction：仅按照glibc"
}
