#!/usr/bin/env bash
#设置完毕后，再每个节点上安装此脚本


#[使用设置]

#集群所有节点的ip
cluster_ip=(192.168.2.108 192.168.2.109)

#端口
port=2181



source script/zookeeper.sh

get_zookeeper_cluster() {
    echo "Do not download"
}

install_zookeeper_cluster() {
    [ -d ${install_dir}/${zookeeper_dir} ] || test_exit "请先安装mysql"

    #配置文件
    echo "clientPort=${port}
dataDir=${install_dir}/${zookeeper_dir}/data
syncLimit=5
tickTime=2000
initLimit=10
dataLogDir=${install_dir}/${zookeeper_dir}
dynamicConfigFile=${install_dir}/${zookeeper_dir}/conf/zoo.cfg.dynamic" > ${install_dir}/${zookeeper_dir}/conf/zoo.cfg

    #输出配置
    rm -rf  ${install_dir}/${zookeeper_dir}/conf/zoo.cfg.dynamic
    d=1
    for i in `echo ${cluster_ip[*]}`
    do
        echo "server.${d}=${i}:2888:3888" >> ${install_dir}/${zookeeper_dir}/conf/zoo.cfg.dynamic
        let d++
    done
    
    #id号
    mkdir ${install_dir}/${zookeeper_dir}/data
    id=`process_id`
    echo "$id" > ${install_dir}/${zookeeper_dir}/data/myid
    
    #监听ipv4，默认ipv6
    sed -i '150c "-Dzookeeper.log.file=${ZOO_LOG_FILE}" "-Djava.net.preferIPv4Stack=true"  "-Dzookeeper.root.logger=${ZOO_LOG4J_PROP}" \/' ${install_dir}/${zookeeper_dir}/bin/zkServer.sh

    #脚本
    command=/usr/local/bin/man-zookeeper
    rm -rf $command
    echo "#!/bin/bash
${install_dir}/${zookeeper_dir}/bin/zkServer.sh" '$1' > $command
    chmod +x $command

    clear
    echo "install ok

bin=/usr/local/bin/man-zookeeper

Start：man-zookeeper start"
}

info_zookeeper_cluster() {
    echo "Name：zookeeper-cluster

version：zookeeper

Introduction：配置zookeeper集群"
}
