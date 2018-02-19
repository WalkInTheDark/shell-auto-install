#!/usr/bin/env bash



#[使用设置]
#主目录，相当于/usr/local
#install_dir=/ops/server

#日志主目录，相当于/var/log
#log_dir=/ops/log

#服务目录名
kafka_manager_dir=kafka-manager

#zookeeper集群地址用,分隔
cluster_ip="192.168.2.108:2181,192.168.2.109:2181"


get_kafka_manager() {
    test_package kafka-manager-1.3.3.14.zip http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/kafka-manager-1.3.3.14.zip 297da17fa75969bc66207e991118b35d
    if [ $language -eq 1 ];then
        echo "kafka-manager-1.3.3.14.zip 下载完成"
    else
        echo "kafka-manager-1.3.3.14.zip Download completed"
    fi
    }

install_kafka_manager() {
    test_install unzip
    test_dir_master
    test_dir ${kafka_manager_dir}
    unzip package/kafka-manager-1.3.3.14.zip
    mv kafka-manager-1.3.3.14 ${install_dir}/${kafka_manager_dir}
    
    conf=${install_dir}/${kafka_manager_dir}/conf/application.conf
    sed -i '23d' $conf
    a=kafka-manager.zkhosts='"'${zookeeper_cluster}'"'
    sed -i "22a $a" $conf

    command=/usr/local/bin/man-kafka-manager
    cp conf/kafka/man-kafka-manager $command
    chmod +x $command

    sed -i "2a port=9000" $command
    sed -i "3a dir=${install_dir}/${kafka_manager_dir}" $command
    sed -i "4a log=${log_dir}/${kafka_manager_dir}"$command

    echo "kafka-manager" >> conf/installed.txt
    [ $language -eq 1 ] && echo "kafka-manager安装完毕，使用man-kafka-manager 管理，登陆http://127.0.0.1:9000 进行查看设置" || ehco "kafka_manager installation is completed, use Man-kafka-manager management，Login http://127.0.0.1:9000 view settings"
}

remove_kafka_manager() {
    man-kafka-manager stop
    rm -rf /usr/local/bin/man-kafka-manager
    rm -rf ${install_dir}/${kafka_manager_dir}
    
    [ $language -eq 1 ] && echo "kafka_manager已卸载" || ehco "kafka_manager Uninstalled"
}

info_kafka_manager() {
    if [ $language -eq 1 ];then
        echo "名字：kafka-manager
        
版本：1.3.3.14

作者：book

介绍：安装kafka-manager，kafka可视化管理工具

提示：只填写zookeeper集群地址即可

使用：man-kafka-manager管理"
    else
        echo "Name：kafka-manager
        
version：1.3.3.14

Author：book

Introduction：Install kafka-manager, kafka visualization management tool

Prompt：Only fill in zookeeper cluster address can be

use：man-kafka-manager management"
    fi
}
