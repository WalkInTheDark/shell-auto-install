#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
redis_dir=redis



#$1有值则不显示下载完成，只显示包名
get_redis() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/redis-3.2.9.tar.gz" "0969f42d1675a44d137f0a2e05f9ebd2"
}

install_redis() {
    #检测目录
    test_dir_master
    test_dir $redis_dir
    
    #安装服务
    tar -xf package/redis-3.2.9.tar.gz
    mv redis ${install_dir}/${redis_dir}

    #环境变量
    grep -w 'PATH=$PATH':${install_dir}/${redis_dir}/bin /etc/profile &> /dev/null
    [ $? -ne 0 ] && echo 'PATH=$PATH':${install_dir}/${redis_dir}/bin >> /etc/profile
    
    #安装完成
    echo "redis" >> conf/installed.txt

    test_info "redis安装成功，可安装redis-port来启动一个实例
安装目录：${install_dir}/${redis_dir}
日志目录：${log_dir}/${redis_dir}
环境变量设置完毕，请退出当前终端后重新进入" "
redis installed successfully, You can install redis-port to start an instance
installation manual：${install_dir}/${redis_dir}
Log directory：${log_dir}/${redis_dir}
Environment variable is set, please exit the current terminal and re-enter"
}

remove_redis() {
    #删除环境变量
    hang=`grep -n 'PATH=$PATH':${install_dir}/${redis_dir}/bin /etc/profile | awk -F: '{print $1}' &> /dev/null`
    sed -i "${hang} d" /etc/profile
    
    #停止服务并删除
    man-redis stop
    rm -rf /usr/local/bin/man-redis*
    rm -rf ${install_dir}/${redis_dir}

    #卸载完成
    test_info "redis卸载完成" "redis uninstall completed"
}

info_redis() {
    test_info "
名字：redis
版本：3.2.9
介绍：仅安装redis
作者：book
提示：无
使用：无" "
Name：redis
version：3.2.9
Introduction：Only redis is installed, but it does not start the instance
Author：book
Prompt：none
use：none"
}
