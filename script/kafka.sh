#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
kafka_dir=kafka



get_kafka() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/kafka_2.12-0.10.2.1.tgz" "fab4b35ba536938144489105cb0091e0"
    
    test_package https://raw.githubusercontent.com/goodboy23/shell-script/master/conf/man-kafka
}

install_kafka() {
    test_dir $kafka_cluster_dir
    
    #安装依赖和包
    bash sai.sh install jdk-eight
    get_kafka
    tar -xf package/kafka_2.12-0.10.2.1.tgz
    mv kafka_2.12-0.10.2.1 ${install_dir}/${kafka_cluster_dir}

    #完成
    clear
        echo "install ok
        
install_dir=${install_dir}/${kafka_cluster_dir}

log_dir=${log_dir}/${kafka_cluster_dir}"
}

info_kafka() {
    echo "Name：kafka
        
version：2.12

Introduction：仅安装kafka"
}
