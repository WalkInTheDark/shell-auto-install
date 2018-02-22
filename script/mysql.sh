#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
mysql_dir=mysql



get_mysql() {
    test_package mysql-5.6.39-linux-glibc2.12-x86_64.tar.gz http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/mysql-5.6.39-linux-glibc2.12-x86_64.tar.gz b2e3a6ba8741ce80e7fcecee4f85c2d4
}

install_mysql() {
    test_dir_master
    test_dir $mysql_dir
    package=`get_mysql`

    #清理mariadb的东西
    for i in `rpm -qa | grep mariadb`; do rpm -e --nodeps $i; done
    
    test_install autoconf libaio bison ncurses-devel
    groupadd mysql
    useradd -g mysql -s /sbin/nologin mysql
    
    
    tar -xf package/$package
    mv mysql-5.6.39-linux-glibc2.12-x86_64 ${install_dir}/${mysql_dir}
    mkdir ${install_dir}/${mysql_dir}/data
    chown -R mysql:mysql ${install_dir}/${mysql_dir}
    chown -R mysql:mysql ${log_dir}/${mysql_dir}
    
    echo "default-character-set=utf8
socket=${install_dir}/${mysql_dir}/mysql.sock
[mysqld]
skip-name-resolve
port = 3306
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

    cd ${install_mysql}/${mysql_dir}
    ./scripts/mysql_install_db --user=mysql --basedir=${install_dir}/${mysql_dir} --datadir=${install_dir}/${mysql_dir}/data/
    
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

    grep 'PATH=$PATH':${install_dir}/${mysql_dir}/bin /etc/profile &> /dev/null
    [ $? -eq 0 ] || echo 'PATH=$PATH':${install_dir}/${mysql_dir}/bin >> /etc/profile
    
    echo "mysql" >> conf/installed.txt
    
    clear
    if [ $language -eq 1 ];then
        echo "mysql 安装成功，请使用systemctl start mysql来启动
        
安装目录：${install_dir}/${mysql_dir}

环境变量设置完毕，请退出当前终端后重新进入"
    else
        echo "mysql installed successfully, please use the systemctl start mysql to start
        
installation manual：${install_dir}/${redis_dir}

Environment variable is set, please exit the current terminal and re-enter"
    fi
}

remove_mysql() {
    systemctl stop mysql ; systemctl disable mysql
    
    hang=`grep -n 'PATH=$PATH':${install_dir}/${mysql_dir}/bin /etc/profile &> /dev/null`
    sed -i "${hang} d" /etc/profile
    
    rm -rf ${install_dir}/${mysql_dir}
    
    [ $language -eq 1 ] && echo "mysql卸载完成" || ehco "mysql Uninstall completed"
}


info_mysql() {
    if [ $language -eq 1 ];then
        echo "名字：mysql
        
版本：6.3.9

作者：book

介绍：安装mysql

提示：无

使用：systemctl start mysql来启动"
    else
        echo "Name：mysql
        
version：6.3.9

Author：book

Introduction：Install mysql

Prompt：none

use：systemctl start mysql to start"
    fi
}
