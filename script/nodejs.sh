#!/usr/bin/env bash



get_nodejs() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/node-v8.9.3-linux-x64.tar.xz" "32948a8ca5e6a7b69c03ec1a23b16cd2"
}

install_nodejs() {
    get_nodejs
    tar -xf package/${package}
    mv node-v8.9.3-linux-x64 /usr/local/nodejs
    
    #链接
    ln -s /usr/local/nodejs/bin/node /usr/local/bin/node
    ln -s /usr/local/nodejs/bin/npm /usr/local/bin/npm

    #对结果进行测试
    node -v
    [ $? -eq 0 ] || test_exit "Installation failed, please check the installation script"
    
    clear
    echo "install ok

install_dir=/usr/local/nodejs

bin_dir=/usr/local/bin/node

bin_dir=/usr/local/bin/npm"
}

info_nodejs() {
    echo "Name：nodejs
        
version：8.9.3

Introduction：安装nodejs"
}
