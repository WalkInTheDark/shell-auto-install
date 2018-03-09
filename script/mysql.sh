#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
mysql_dir=mysql



get_mysql() {
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/mysql-5.6.39-linux-glibc2.12-x86_64.tar.gz" "1bc406d2fe18dd877182a0bd603e7bd4"
}

install_mysql() {
    #检测目录
    test_dir_master
    test_dir $mysql_dir

    #清理mariadb的东西
    for i in `rpm -qa | grep mariadb`; do rpm -e --nodeps $i; done
    
    test_install autoconf libaio bison ncurses-devel
    groupadd mysql
    useradd -g mysql -s /sbin/nologin mysql
    
    get_mysql
    tar -xf package/mysql-5.6.39-linux-glibc2.12-x86_64.tar.gz
    mv mysql-5.6.39-linux-glibc2.12-x86_64 ${install_dir}/${mysql_dir}
    chown -R mysql:mysql ${install_dir}/${mysql_dir}
    chown -R mysql:mysql ${log_dir}/${mysql_dir}

    echo "mysql" >> conf/installed.txt #后面将不会退出

    grep 'PATH=$PATH':${install_dir}/${mysql_dir}/bin /etc/profile
    [ $? -eq 0 ] || echo 'PATH=$PATH':${install_dir}/${mysql_dir}/bin >> /etc/profile

    clear
    if [ $language -eq 1 ];then
        echo "mysql安装完成，可以安装mysql-single启动单点
        
安装目录：${install_dir}/${mysql_dir}

日志目录：${log_dir}/${mysql_dir}

环境变量设置完毕，请退出当前终端后重新进入" 
    else
        echo "mysql installation is complete, you can install mysql-single boot a single point
        
installation manual：${install_dir}/${redis_dir}

Log directory：${log_dir}/${mysql_dir}

Environment variable is set, please exit the current terminal and re-enter"
}

remove_mysql() {
    hang=`grep -n 'PATH=$PATH':${install_dir}/${mysql_dir}/bin /etc/profile | awk -F':' '{print $1}' `
    [ ! $hang ] || sed -i "${hang} d" /etc/profile
    
    rm -rf ${install_dir}/${mysql_dir}
    userdel -r mysql
    
    [ $language -eq 1 ] && "mysql卸载完成" || "mysql Uninstall completed"
}

info_mysql() {
if [ $language -eq 1 ];then
    echo "名字：mysql

版本：6.3.9

介绍：仅安装mysql

作者：book

提示：无

使用：无"
else
    echo "Name：mysql
    
version：6.3.9

Introduction：Only install mysql

Author：book

Prompt：none

use：none"
fi
}
