#!/usr/bin/env bash



#[使用设置]

#开启实例的端口
cluster_ip=(3307 3308)

#非0则关闭依赖
rely=0



#加载依赖
source script/mysql.sh

get_mysql_port() {
    get_mysql
}

install_mysql_port() {
    [ $rely -eq 0 ] && test_rely mysql
 
     echo "[client]
port=3306
socket=${install_dir}/${mysql_dir}/mysql.sock

[mysqld_multi]
mysqld=${install_dir}/${mysql_dir}/bin/mysqld_safe
mysqladmin=${install_dir}/${mysql_dir}/bin/mysqladmin
log=${log_dir}/${mysql_dir}/mysqld_multi.log

[mysqld]
user=mysql
basedir=${install_dir}/${mysql_dir}
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES"  > /etc/my.cnf #基本配置

    for i in `echo ${cluster_ip[*]}`
    do
        [ -d ${install_dir}/${mysql_dir}/data${i} ] && continue
        mkdir ${install_dir}/${mysql_dir}/data${i}
        echo "[mysqld${i}]  
mysqld=mysqld  
mysqladmin=mysqladmin  
datadir=${install_dir}/${mysql_dir}/data${i}
port=${i}
server_id=${i}  
socket=${install_dir}/${mysql_dir}/mysql_${i}.sock  
log-output=file  
slow_query_log = 1  
long_query_time = 1  
slow_query_log_file =${install_dir}/${mysql_dir}/${i}_slow.log  
log-error =${install_dir}/${mysql_dir}/${i}_error.log  
binlog_format = mixed  
log-bin =${install_dir}/${mysql_dir}/${i}_bin" >> /etc/my.cnf
    done
    
    chown -R mysql:mysql ${install_dir}/${mysql_dir}
    
    for i in `echo ${cluster_ip}`
    do
        ${install_dir}/${mysql_dir}/scripts/mysql_install_db --basedir=${install_dir}/${mysql_dir} --datadir=${install_dir}/${mysql_dir}/data${i} --defaults-file=/etc/my.cnf &> /dev/null
    done

    test_info "
mysql-port安装成功，请使用mysqld_multi start 来启动所有实例
登陆： mysql -S ${install_dir}/${mysql_many_dir}/mysql_${i}.sock" "
mysql-many installed successfully, please use the systemctl start mysql to start
Login：mysql -S ${install_dir}/${mysql_many_dir}/mysql_${i}.sock"
}

remove_mysql_port() {
    for i in `echo ${cluster_ip[*]}`
    do
        mysqld_multi stop $i
        rm -rf ${install_dir}/${mysql_dir}/data${i}
    done

    test_info "mysql-port卸载完成" "mysql-port Uninstall completed"
}

info_mysql_port() {
    test_info "
名字：mysql-port
依赖：mysql
介绍：安装mysql多实例
作者：book
提示：无
使用：man-mysql-port管理" "
Name：mysql-port
rely：mysql
Introduction：Install mysql multi-instance
Author：book
Prompt：none
use：man-mysql-port management"
}
