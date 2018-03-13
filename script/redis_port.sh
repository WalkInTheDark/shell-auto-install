#!/usr/bin/env bash
#启动多个端口


#[使用设置]

#可使用非sai安装的redis
#install_dir=

#log_dir=

#redis_dir=

#将安装如下端口实例
port=(6379)

#监听ip
listen=0.0.0.0



get_redis_port() {
    test_package https://raw.githubusercontent.com/goodboy23/shell-script/master/conf/redis_7000.conf
    
    test_package https://raw.githubusercontent.com/goodboy23/shell-script/master/conf/man-redis
}

install_redis_port() {
    #变量不存在，则使用redis.sh脚本的
    [ ! $install_dir ] && source script/redis.sh
    [ -d ${install_dir}/${redis_dir} ] || test_exit "请先安装redis"

    for i in `echo ${port[*]}`
    do
        command=/usr/local/bin/man-redis${i} #创建单独管理脚本
        if [ ! -f $command ];then
            cp package/man-redis $command
        
            sed -i "2a port=${i}" $command
            sed -i "3a install_dir=${install_dir}" $command
            sed -i "4a log_dir=${log_dir}" $command
            sed -i "5a redis_dir=${redis_dir}" $command
        
            chmod +x $command
        else
            continue #如果管理脚本存在，则跳过这个端口
        fi

        conf=${install_dir}/${redis_dir}/cluster/${i}/${i}.conf
        
        mkdir -p ${install_dir}/${redis_dir}/cluster/${i}
        cp package/redis_7000.conf $conf
        
        sed -i "s/^bind 127.0.0.1/bind ${listen}/g" $conf
        sed -i "/^port/cport ${i}" $conf
        sed -i "/^cluster-config-file/ccluster-config-file nodes_${i}.conf" $conf
        sed -i "/^pidfile/cpidfile redis_${i}.pid" $conf
        sed -i "/^dir/cdir ${install_dir}/${redis_dir}/cluster/${i}" $conf 
    done

    #创建总管理脚本
    echo '#!/bin/bash

for i in `ls /usr/local/bin/man-redis*`
do  
    [ "/usr/local/bin/$i" == "man-redis" ] && continue || $i $1
done' >> /usr/local/bin/man-redis
    chmod +x /usr/local/bin/man-redis

    #测试
    which $i
    [ $? -eq 0 ] || test_exit "Installation failed, please check the script"
    
    
    clear
    echo "install ok
    
install_dir=${install_dir}/${redis_dir}/cluster

bin_dir=/usr/local/bin/man-redis*

use man-redis start"
}

info_redis_port() {
    echo "Name：redis-port
       
rely：redis

Introduction：配置redis多实例"
}
