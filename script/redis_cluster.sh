#!/usr/bin/env bash
#此脚本将创建集群，需要设置端口


#[使用设置]

#可使用非sai安装的redis
#install_dir=

#redis_dir=

#所有要加入集群的节点，前一半节点皆为主
cluster_ip="127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005"

#默认1主1从，设置2就是1主2从
node=1



get_redis_cluster() {
    get_redis
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/redis-4.0.1.gem" "a4b74c19159531d0aa4c3bf4539b1743"
}

install_redis_cluster() {  
    [ ! $redis_dir ] || source script/redis.sh
    [ -d ${install_dir}/${redis_dir} ] || test_exit "请先安装redis"

    get_redis_cluster
    test_install ruby-devel rubygems rpm-build
    bash sai.sh install ruby
    gem install package/redis-4.0.1.gem
    
    #启动
    ${install_dir}/${redis_dir}/src/redis-trib.rb create --replicas ${node} ${cluster_ip}
    
    #测试
    
    clear
    echo "install ok"
}

info_redis_cluster() {
    echo "Name：redis-cluster
        
rely：redis

Introduction：配置redis集群"
}
