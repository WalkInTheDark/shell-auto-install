#!/usr/bin/env bash
#kafka-manager，可以用来监控kafka



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
kafka_manager_dir=kafka-manager

#zookeeper集群地址用,分隔
cluster_ip="192.168.2.108:2181,192.168.2.109:2181"

#启动端口
port=9000



get_kafka_manager() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/kafka-manager-1.3.3.14.zip" "297da17fa75969bc66207e991118b35d"
}

install_kafka_manager() {
    test_install unzip
    test_dir ${kafka_manager_dir}
    
    #安装包
    get_kafka_manager
    unzip package/kafka-manager-1.3.3.14.zip
    mv kafka-manager-1.3.3.14 ${install_dir}/${kafka_manager_dir}
    
    #修改配置文件
    conf=${install_dir}/${kafka_manager_dir}/conf/application.conf
    a=kafka-manager.zkhosts='"'${cluster_ip}'"'
    sed -i "23c $a" $conf

    #创建管理脚本
    test_bin man-kafka-manager

    sed -i "2a port=${port}" $command
    sed -i "3a dir=${install_dir}/${kafka_manager_dir}" $command
    sed -i "4a log=${log_dir}/${kafka_manager_dir}" $command
    
    #完成
    clear
    echo "install ok
        
install_dir=${install_dir}/${kafka_manager_dir}

log_dir=${log_dir}/${kafka_manager_dir}

bin=/usr/local/bin/man-kafka-manager

Start：man-kafka-manager start

Test：curl http://127.0.0.1:${port} login"
}

info_kafka_manager() {
    echo "Name：kafka-manager
        
version：1.3.3.14

Introduction：安装kafka-manager"
}