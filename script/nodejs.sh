#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#服务目录名
modejs_dir=nodejs



get_nodejs() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/node-v8.9.3-linux-x64.tar.xz" "32948a8ca5e6a7b69c03ec1a23b16cd2"
}

install_nodejs() {
    #检测目录
    test_dir $nodejs_dir

    get_nodejs
    tar -xf package/node-v8.9.3-linux-x64.tar.xz
    mv node-v8.9.3-linux-x64 ${install_dir}/${nodejs_dir}
    
    #链接
    rm -rf /usr/local/bin/node
    rm -rf /usr/local/bin/npm
    ln -s ${install_dir}/${nodejs_dir}/bin/node /usr/local/bin/node
    ln -s ${install_dir}/${nodejs_dir}/bin/npm /usr/local/bin/npm

    #对结果进行测试
    node -v
    [ $? -eq 0 ] || test_exit "Installation failed, please check the installation script"
    
    clear
    echo "install ok

install_dir=${install_dir}/${nodejs_dir}

bin_dir=${install_dir}/${nodejs_dir}/node

bin_dir=${install_dir}/${nodejs_dir}/npm"
}

info_nodejs() {
    echo "Name：nodejs
        
version：8.9.3

Introduction：安装nodejs"
}
