#!/usr/bin/env bash
#


#[使用设置]

#可自定义
#install_dir=

#log_dir=

#kafka_dir=kafka

#zookeeper集群的ip，包括他自己
cluster_ip=(192.168.2.108:2181 192.168.2.109:2181)


source script/kafka.sh

get_kafka_cluster() {
    echo "Do not download"
}

install_kafka_cluster() {
    [ -d ${install_dir}/${kafka_dir} ] || test_exit "请先安装kakfa"
    
    conf=${install_dir}/${kafka_dir}/config/server.properties
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
    sed -i "63s,log.dirs=/ops/log/kafka,log.dirs=${log_dir}/${kafka_dir},g" $conf
    sed -i "119s/zookeeper.connect=B-S-01:2181/zookeeper.connect=${cluster_dizhi}/g" $conf

    command=/usr/local/bin/man-kafka
    cp package/man-kafka $command
    chmod +x $command
    sed -i "2a dir=${install_dir}/${kafka_cluster_dir}" $command
    
    echo "install ok
    
man-kafka start"
}

info_kafka_cluster() {
    echo "Name：kafka-cluster
        
version：2.12

Introduction：配置kafka集群"
}
