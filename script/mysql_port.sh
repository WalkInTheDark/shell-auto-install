#!/usr/bin/env bash



#[使用设置]

#可自定义
#install_dir=

#log_dir=

#mysql_dir=

#开启实例的端口
cluster_ip=(3307 3308)



source script/mysql.sh

get_mysql_port() {
    echo "Do not download"
}

install_mysql_port() {
    [ -d ${install_dir}/${mysql_dir} ] || test_exit "请先安装mysql"
 
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
slow_query_log_file =${log_dir}/${mysql_dir}/${i}_slow.log  
log-error =${log_dir}/${mysql_dir}/${i}_error.log  
binlog_format = mixed  
log-bin =${log_dir}/${mysql_dir}/${i}_bin" >> /etc/my.cnf
echo >> /etc/my.cnf
    done
    
    chown -R mysql:mysql ${install_dir}/${mysql_dir}
    
    for i in `echo ${cluster_ip}`
    do
        ${install_dir}/${mysql_dir}/scripts/mysql_install_db --basedir=${install_dir}/${mysql_dir} --datadir=${install_dir}/${mysql_dir}/data${i} --defaults-file=/etc/my.cnf &> /dev/null
    done

    echo "install ok

install_dir=${install_dir}/${mysql_dir}/data*

mysqld_multi start

mysql -S ${install_dir}/${mysql_many_dir}/mysql_${i}.sock"
}

info_mysql_port() {
    echo "Name：mysql-port
        
rely：mysql

Introduction：配置mysql多实例"
}
