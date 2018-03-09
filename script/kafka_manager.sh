#!/usr/bin/env bash




#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
kafka_manager_dir=kafka-manager

#zookeeper集群地址用,分隔
cluster_ip="192.168.2.108:2181,192.168.2.109:2181"


get_kafka_manager() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/kafka-manager-1.3.3.14.zip" "297da17fa75969bc66207e991118b35d"
}

install_kafka_manager() {
    test_install unzip
    test_dir_master
    test_dir ${kafka_manager_dir}
    
    get_kafka_manager
    unzip package/${package} &> /dev/null
    mv kafka-manager-1.3.3.14 ${install_dir}/${kafka_manager_dir}
    
    conf=${install_dir}/${kafka_manager_dir}/conf/application.conf
    a=kafka-manager.zkhosts='"'${cluster_ip}'"'
    sed -i "23c $a" $conf

    command=/usr/local/bin/man-kafka-manager
    cp conf/kafka/man-kafka-manager $command
    chmod +x $command

    sed -i "2a port=9000" $command
    sed -i "3a dir=${install_dir}/${kafka_manager_dir}" $command
    sed -i "4a log=${log_dir}/${kafka_manager_dir}" $command

    echo "kafka-manager" >> conf/installed.txt
    
    clear
    if [ $language -eq 1 ];then
    echo "kafka-manager安装成功，使用man-kafka-manager管理
        
安装目录：${install_dir}/${kafka_manager_dir}

日志目录：${log_dir}/${kafka_manager_dir}

浏览器输入 http://127.0.0.1:9000登陆"
    else
        echo "kafka-manager installed successfully, using man-kafka-manager management
        
installation manual：${install_dir}/${kafka_manager_dir}

Log directory：${log_dir}/${kafka_manager_dir}

Browser input http://127.0.0.1:9000 login"
    fi
}

remove_kafka_manager() {
    man-kafka-manager stop
    rm -rf /usr/local/bin/man-kafka-manager
    rm -rf ${install_dir}/${kafka_manager_dir}
    
    [ $language -eq 1 ] && echo "kafka_manager已卸载" || echo "kafka_manager Uninstalled"
}

info_kafka_manager() {
    if [ $language -eq 1 ];then
        echo "名字：kafka-manager
        
版本：1.3.3.14

介绍：安装kafka-manager

作者：book

提示：只填写zookeeper集群地址即可

使用：man-kafka-manager管理"
    else
        echo "Name：kafka-manager
        
version：1.3.3.14

Introduction：Install kafka-manager

Author：book

Prompt：Only fill in zookeeper cluster address can be

use：man-kafka-manager management"
    fi
}
