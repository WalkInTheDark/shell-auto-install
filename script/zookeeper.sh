#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
zookeeper_dir=zookeeper



get_zookeeper() {
    test_package http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/zookeeper-3.5.2-alpha.tar.gz adc27d412f283c0dc6ec9d08e30f4ec0
}

install_zookeeper() {
    #检测目录
    test_dir $zookeeper_dir
    bash sai.sh install jdk-eight

    get_zookeeper
    tar -xf   package/zookeeper-3.5.2-alpha.tar.gz
    mv zookeeper-3.5.2-alpha ${install_dir}/${zookeeper_dir}

    #测试
    
    clear
    echo "install ok
        
install_dir=${install_dir}/${zookeeper_dir}

log_dir=${log_dir}/${zookeeper_dir}"
}

info_zookeeper() {
    echo "Name：zookeeper
    
version：3.5.2

Introduction：仅安装zookeeper"
}
