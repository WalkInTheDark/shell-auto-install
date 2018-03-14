#!/usr/bin/env bash
#mindoc，小型wiki，适合个人和公司使用


#[使用设置]

#当前只支持使用sqlite3数据库安装

#主目录，相当于/usr/local
#install_dir=

#日志主目录，相当于/var/log
#log_dir=

#服务目录名
mindoc_dir=mindoc

#端口
port=8181



get_mindoc() {
    test_package http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/mindoc.zip 55a5df03b3503802560b430d5045a154
}

install_mindoc() {
    #检测目录
    test_dir $mindoc_dir
    
    #安装服务
    get_mindoc
    test_install unzip 
    unzip package/mindoc_linux_amd64.zip
    mv mindoc ${install_dir}/${mindoc_dir}
    
    conf=${install_dir}/${mindoc_dir}/conf/app.conf
    sed -i "s/^httpport/httpport = ${port}/g" $conf
    
    sqlite3 -version
    [ $? -eq 0 ] || bash sai.sh install sqlite3
    
    strings /lib64/libc.so.6 |grep ^GLIBC_2.14
    [ $? -eq 0 ] || bash sai.sh install glibc

    test_bin man-mindoc
    sed -i "2a install_dir=${install_dir}" $command
    sed -i "3a log_dir=${log_dir}" $command
    sed -i "4a mindoc_dir=${mindoc_dir}" $command

    clear
        echo "install ok

install_dir=${install_dir}/${mindoc_dir}

log_dir=${log_dir}/${mindoc_dir}

Start：man-start start

Test：curl httP://127.0.0.1:${port}"
}

info_mindoc() {
    echo "Name：mindoc
        
version：0.9

Introduction：仅安装mindoc"
}
