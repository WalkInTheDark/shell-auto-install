#!/usr/bin/env bash



#[使用设置]

#默认端口
port=3306

#非0则不检测依赖
rely=0



#加载它的依赖
source script/mysql.sh

get_mysql_single() {
    get_mysql
}

install_mysql_single() {
    [ $rely -eq 0 ] && test_rely mysql
    
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
    
    cd ${install_dir}/${mysql_dir}
    ./scripts/mysql_install_db --user=mysql --basedir=${install_dir}/${mysql_dir} --datadir=${install_dir}/${mysql_dir}/data &> /dev/null
    
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
    
    echo "mysql-single" >> conf/installed.txt

    test_info "mysql-single安装成功，systemctl管理" "mysql-single installation is successful, systemctl management"
}

remove_mysql_single() {
    systemctl stop mysql ; systemctl disable mysql
    rm -rf /usr/lib/systemd/system/mysql.service
    
    test_info "mysql-single卸载完成" "mysql-single uninstall completed" 
}
