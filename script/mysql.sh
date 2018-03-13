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

    echo 'PATH=$PATH':${install_dir}/${mysql_dir}/bin >> /etc/profile

    #测试
    
    
    clear
    echo "install ok
        
install_dir=${install_dir}/${redis_dir}

log_dir=${log_dir}/${mysql_dir}

PATH /et/profile"
}

info_mysql() {
    echo "Name：mysql
    
version：6.3.9

Introduction：仅安装mysql"
}
