#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
redis_dir=redis



get_redis() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/redis-3.2.9.tar.gz" "0969f42d1675a44d137f0a2e05f9ebd2"
}

install_redis() {
    #检测目录
    test_dir_master
    test_dir $redis_dir
    
    #安装服务
    get_redis
    tar -xf package/redis-3.2.9.tar.gz
    mv redis ${install_dir}/${redis_dir}
    
    #环境变量
    echo 'PATH=$PATH':${install_dir}/${redis_dir}/bin >> /etc/profile
    
    #测试
    source /etc/profile
    which redis-cli
    [ $? -eq 0 ] || test_exit "Installation failed, please check the script" 

    clear
        echo "install ok

install_dir=${install_dir}/${redis_dir}

log_dir=${log_dir}/${redis_dir}

PATH in /etc/profile"
}

info_redis() {
    echo "Name：redis
        
version：3.2.9

Introduction：仅安装redis"
}
