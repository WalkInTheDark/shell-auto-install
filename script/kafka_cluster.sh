#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
kafka_cluster_dir=kafka

#zookeeper集群的ip，包括他自己
cluster_ip=(192.168.2.108:2181 192.168.2.109:2181)



get_kafka_cluster() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/kafka_2.12-0.10.2.1.tgz" "fab4b35ba536938144489105cb0091e0"
}

install_kafka_cluster() {
    test_dir_master
    test_dir $kafka_cluster_dir
    test_install java-1.8.0-openjdk
    
    get_kafka_cluster
    tar -xf package/${package}
    mv kafka_2.12-0.10.2.1 ${install_dir}/${kafka_cluster_dir}

    conf=${install_dir}/${kafka_cluster_dir}/config/server.properties
    rm -rf $conf #删除旧的
    cp conf/kafka/server.properties $conf
    
    id=`process_id`
    ip=`process_ip`
    
    for i in `echo ${cluster_ip[*]}` #算出地址字符串
    do
        if [ "$i" == "${cluster_ip[0]}" ];then #刨去第一个，不然最前面会多个,
            cluster_dizhi=`echo $i`
        else
            cluster_dizhi=`echo ${cluster_dizhi},$i`
        fi
    done

    sed -i "21s/broker.id=1/broker.id=${id}/g" $conf
    sed -i "35s/advertised.host.name=192.168.100.11/advertised.host.name=${ip}/g" $conf
    sed -i "63s,log.dirs=/ops/log/kafka,log.dirs=${log_dir}/${kafka_cluster_dir},g" $conf
    sed -i "119s/zookeeper.connect=B-S-01:2181/zookeeper.connect=${cluster_dizhi}/g" $conf

    command=/usr/local/bin/man-kafka
    cp conf/kafka/man-kafka $command
    chmod +x $command
    sed -i "2a dir=${install_dir}/${kafka_cluster_dir}" $command
    
    echo "kafka-cluster" >> conf/installed.txt

    clear
        if [ $language -eq 1 ];then
        echo "kafka-cluster安装成功，请安装man-kafka管理
        
安装目录：${install_dir}/${kafka_cluster_dir}

日志目录：${log_dir}/${kafka_cluster_dir}"
    else
        echo "kafka-cluster installed successfully, please install man-kafka management
        
installation manual：${install_dir}/${kafka_cluster_dir}

Log directory：${log_dir}/${kafka_cluster_dir}"
    fi
}

remove_kafka_cluster() {
    man-kafka stop
    rm -rf /usr/local/bin/kafka-kafka
    rm -rf ${install_dir}/${kafka_cluster_dir}
    
    [ $language -eq 1 ] && echo "kafka_cluster已卸载" || echo "kafka_cluster Uninstalled"
}

info_kafka_cluster() {
    if [ $language -eq 1 ];then
        echo "名字：kafka-cluster
        
版本：2.12

介绍：安装kafka集群

作者：book

提示：只需要填写集群地址即可

使用：man-kafka管理"
    else
        echo "Name：kafka-cluster
        
version：2.12

Introduction：Install kafka cluster

Author：book

Prompt：Only need to fill in the cluster address can be

use：Man-kafka management"
    fi
}
