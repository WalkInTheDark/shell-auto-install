#!/usr/bin/env bash

#此脚本只进行redis的安装，若要使用，请安装redis_port

#[使用设置]
#主目录，相当于/usr/local
install_dir=/ops/server

#日志主目录，相当于/var/log
log_dir=/ops/log

#服务目录名
redis_dir=redis



get_redis() {
    test_package redis-3.2.9.tar.gz http://www.baidu.com/redis  0969f42d1675a44d137f0a2e05f9ebd2
    if [ $language -eq 1 ];then
        echo "redis-3.2.9.tar.gz 下载完成"
    else
        echo "redis-3.2.9.tar.gz Download completed"
    fi
}

install_redis() {
    test_dir_master
    test_dir $redis_dir
    get_redis

    tar -xf package/redis-3.2.9.tar.gz
    mv redis ${install_dir}/${redis_dir}

    grep -w 'PATH=$PATH':${install_dir}/${redis_dir}/bin /etc/profile &> /dev/null
    if [ $? -ne 0 ];then
        echo 'PATH=$PATH':${install_dir}/${redis_dir}/bin >> /etc/profile
    fi
    
    clear
    if [ $language -eq 1 ];then
        echo "redis 安装成功，请安装redis_port来启动一个实例"
        echo
        echo "安装目录：${install_dir}/${redis_dir}"
        echo
        echo "环境变量设置完毕，请退出当前终端后重新进入"
    else
        echo "redis installed successfully, please install redis_port to start an instance"
        echo
        echo "installation manual：${install_dir}/${redis_dir}"
        echo
        echo "Environment variable is set, please exit the current terminal and re-enter"
    fi
}

remove_redis() {
    [ -f /usr/local/bin/redis-man ] && echo redis-man stop all

    rm -rf ${install_dir}/${redis_dir}
    rm -rf /usr/local/bin/redis-man

    [ $language -eq 1 ] && echo "redis已卸载" || echo "redis Uninstalled"
}
