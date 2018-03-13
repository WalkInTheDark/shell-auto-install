#!/usr/bin/env bash



#[使用设置]

#可自定义
#install_dir=

#log_dir=

#mysql_dir=

#默认端口
port=3306



get_mysql_single() {
    echo "Do not download"
}

install_mysql_single() {
    [ ! $install_dir ] || source script/mysql.sh
    
    echo "[mysql]
default-character-set=utf8
socket=${install_dir}/${mysql_dir}/mysql.sock
[mysqld]
skip-name-resolve
port = ${port}
socket=${install_dir}/${mysql_dir}/mysql.sock
basedir=${install_dir}/${mysql_dir}
datadir=${install_dir}/${mysql_dir}/data
max_connection=200
character-set-server=utf8
default-storage-engine=INNODB
lower_case_table_name=1
max_allowed_packet=16M
log-error=${log_dir}/${mysql_dir}/mysql.log
pid-file=${log_dir}/${mysql_dir}/mysql.pid
bind-address = 0.0.0.0" > /etc/my.cnf #这里改需要的配置
    chown mysql:mysql /etc/my.cnf
    
    #初始化脚本
    cd ${install_dir}/${mysql_dir}
    ./scripts/mysql_install_db --user=mysql --basedir=${install_dir}/${mysql_dir} --datadir=${install_dir}/${mysql_dir}/data &> /dev/null
    
    #加入systemctl
    echo "[Unit]
Description=mysql
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
ExecStart=${install_dir}/${mysql_dir}/support-files/mysql.server start
ExecReload=${install_dir}/${mysql_dir}/support-files/mysql.server restart
ExecStop=${install_dir}/${mysql_dir}/support-files/mysql.server stop
PrivateTmp=true

[Install]
WantedBy=multi-user.target" > /usr/lib/systemd/system/mysql.service

    systemctl daemon-reload

    clear
    echo "install ok
    
systemctl start mysql"
}

info_mysql_single() {
    echo "Name：mysql-single
    
rely：mysql

Introduction：安装mysql单点"
}
