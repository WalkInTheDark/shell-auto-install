#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
mysql_many_dir=mysql

#开启实例的端口
cluster_ip=(3307 3308)


get_mysql_many() {
    test_package mysql-5.6.39-linux-glibc2.12-x86_64.tar.gz http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/mysql-5.6.39-linux-glibc2.12-x86_64.tar.gz

    if [ ! -n "$1" ];then
        [ $language -eq 1 ] && echo "下载完成" || echo "Download completed"
    fi
}

install_mysql_many() {
    test_dir_master
    test_dir $mysql_many_dir

    #清理mariadb的东西
    for i in `rpm -qa | grep mariadb`; do rpm -e --nodeps $i; done
    
    test_install autoconf libaio bison ncurses-devel
    groupadd mysql
    useradd -g mysql -s /sbin/nologin mysql
    
    package=`get_mysql_many 1`
    tar -xf package/$package
    mv mysql-5.6.39-linux-glibc2.12-x86_64 ${install_dir}/${mysql_many_dir}
    chown -R mysql:mysql ${install_dir}/${mysql_dir}
    chown -R mysql:mysql ${log_dir}/${mysql_dir}
    
    echo "[mysqld_multi]
mysqld=${install_dir}/${mysql_many_dir}/bin/mysqld_safe
mysqladmin=${install_dir}/${mysql_many_dir}/bin/mysqladmin
log=${log_dir}/${mysql_many_dir}mysqld_multi.log

[mysqld]
user=mysql
basedir=${install_dir}/${mysql_many_dir}
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

!includedir /etc/my.cnf.d"  > /etc/my.cnf #基本配置

    mkdir -p /etc/my.cnf.d
    
    for i in `echo ${cluster_ip[*]}`
    do
    
        mkdir {install_dir}/${mysql_many_dir}/data${i}
        echo "[mysql${i}]
mysqld=mysqld
mysqladmin=mysqladmin
bind-address=0.0.0.0
port=${i}
server_id=${i}
datadir=${install_dir}/${mysql_many_dir}/data${i}
socket=${install_dir}/${mysql_many_dir}/mysql_${i}.sock
log-output=file
slow_query_log=1
long_query_time=1
slow_query_log_file=${log_dir}/${mysql_many_dir}/mysql/${i}slow.log
log-error=${log_dir}/${mysql_many_dir}/mysql/${i}error.log
binlog_format=mixed
log-bin=${log_dir}/${mysql_many_dir}/mysql/mysql${i}_bin" > /etc/my.cnf.d/${i}.conf
    done
    
     chown mysql:mysql /etc/my.cnf
     
    for i in `echo ${cluster_ip}`
    do
        ${install_dir}/${mysql_many_dir}/scripts/mysql_install_db --basedir=${install_dir}/${mysql_many_dir} --datadir=${install_dir}/${mysql_many_dir}/data${i} --defaults-file=/etc/my.cnf &> /dev/null
    done

    grep 'PATH=$PATH':${install_dir}/${mysql_many_dir}/bin /etc/profile &> /dev/null
    [ $? -eq 0 ] || echo 'PATH=$PATH':${install_dir}/${mysql_many_dir}/bin >> /etc/profile
    
    clear
    if [ $language -eq 1 ];then
        echo "mysql-many 安装成功，请使用mysqld_multi start 来启动所有实例
        
安装目录：${install_dir}/${mysql_many_dir}
          所有实例数据目录则data*

日志目录：${log_dir}/${mysql_many_dir}

环境变量设置完毕，请退出当前终端后重新进入

登陆： mysql -S ${install_dir}/${mysql_many_dir}/mysql_${i}.sock"
    else
        echo "mysql-many installed successfully, please use the systemctl start mysql to start
        
installation manual：${install_dir}/${mysql_many_dir}
                     All instance data directory data *

Log directory：${log_dir}/${mysql_many_dir}

Environment variable is set, please exit the current terminal and re-enter

Login：mysql -S ${install_dir}/${mysql_many_dir}/mysql_${i}.sock"
    fi
}

remove_mysql_many() {
    mysqld_multi
    
    hang=`grep -n 'PATH=$PATH':${install_dir}/${mysql_many_dir}/bin /etc/profile &> /dev/null`
    sed -i "${hang} d" /etc/profile
    
    rm -rf ${install_dir}/${mysql_many_dir}
    userdel -r mysql
    
    [ $language -eq 1 ] && echo "mysql-many卸载完成" || echo "mysql-many Uninstall completed"
}

info_mysql_many() {
    if [ $language -eq 1 ];then
        echo "名字：mysql-many
        
版本：6.3.9

介绍：安装mysql多实例

作者：book

提示：无

使用：mysqld_multi 管理"
    else
        echo "Name：mysql-many
        
version：6.3.9

Introduction：Install mysql multi-instance

Author：book

Prompt：none

use：mysqld_multi management"
    fi
}
