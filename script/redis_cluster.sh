#!/usr/bin/env bash

#这里只进行集群管理端的创建，端口使用redis_port创建

#[使用设置]
#所有要加入集群的节点，前一半节点皆为主
cluster_ip="127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005"

#默认1主1从，设置2就是1主2从
node=1



get_redis_cluster() {
    source script/redis.sh
    get_redis
}

install_redis_cluster() {
    source script/redis.sh
   
    bash sai.sh list installed | grep "^redis" &> dev/null
    [ $? -ne 0 ] && test_exit "请先安装redis" "Please install redis"

    test_install ruby-devel rubygems rpm-build
    bash sai.sh install ruby #这个手动装好点
    gem install conf/redis/redis-3.0.0.gem
    
    ${install_dir}/${redis_dir}/src/redis-trib.rb create --replicas ${node} ${cluster_ip}
    
    if [ $language -eq 1 ];then
        clear
        echo "redis集群已启动完成"
    else
        clear
        echo "redis cluster has started to complete"
    fi
}


remove_redis_cluster() {
    if [ $language -eq 1 ];then
        echo "集群无法停止，停止只能关闭所有节点并'备份删除'所有节点的dump.db，appendonly.aof，nodes.conf文件后启动"
    else
        "Cluster can not stop, stop only shut down all nodes and 'backup delete' all nodes after dump.db, appendonly.aof, nodes.conf file started"
    fi
}

info_redis_cluster() {
    if [ $language -eq 1 ];then
        echo "名字：redis-cluster
       
版本：3.2.9

作者：book

介绍：创建一个redis集群

提示：需要编辑加入集群的节点，至少6个点，3主3从

使用：集群使用和测试方法敬请百度"
    else
        echo "Name：redis-cluster
        
version：3.2.9

Author：book

Introduction：Create a redis cluster

Prompt：Need to edit join the cluster node, at least 6 points, 3 main 3 from

use：Baidu use and test methods please Baidu"
    fi
}
