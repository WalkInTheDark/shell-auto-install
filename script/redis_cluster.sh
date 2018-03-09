#!/usr/bin/env bash



#[使用设置]

#所有要加入集群的节点，前一半节点皆为主
cluster_ip="127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005"

#默认1主1从，设置2就是1主2从
node=1

#非0则不检测依赖
rely=0



#加载它的依赖
source script/redis.sh

get_redis_cluster() {
    get_redis
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/redis-4.0.1.gem" "a4b74c19159531d0aa4c3bf4539b1743"
}

install_redis_cluster() {  
    [ $rely -eq 0 ] && test_rely redis

    get_redis_cluster
    test_install ruby-devel rubygems rpm-build
    bash sai.sh install ruby #这个手动装好点
    gem install package/redis-4.0.1.gem
    
    ${install_dir}/${redis_dir}/src/redis-trib.rb create --replicas ${node} ${cluster_ip}
    
    clear
    [ $language -eq 1 ] && echo "redis集群已启动完成" || echo "redis cluster has started to complete"
}


remove_redis_cluster() {
    if [ $language -eq 1 ];then
        echo "集群无法停止，停止只能关闭所有节点并'备份删除'所有节点的dump.db，appendonly.aof，nodes.conf文件后启动"
    else
        echo "Cluster can not stop, stop only shut down all nodes and 'backup delete' all nodes after dump.db, appendonly.aof, nodes.conf file started"
    fi
}

info_redis_cluster() {
    if [ $language -eq 1 ];then
        echo "名字：redis-cluster
       
依赖：redis

介绍：创建redis集群

作者：book

提示：需要编辑加入集群的节点，至少6个点，3主3从

使用：集群使用和测试方法敬请百度"
    else
        echo "Name：redis-cluster
        
rely：redis

Introduction：Create a redis cluster

Author：book

Prompt：Need to edit join the cluster node, at least 6 points, 3 main 3 from

use：Baidu use and test methods please Baidu"
    fi
}
