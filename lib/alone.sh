#!/usr/bin/env bash
#alone组 用于搭配安装软件
set -u #使用不存在变量将退出报错


#测试是否关闭selinux
test_selinux(){
    if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
        sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
        setenforce 0
    fi
}

#测试主目录是否存在
test_dir_master() {
    if [[ ! -d ${install_dir} ]];then
        mkdir -p ${install_dir}
    fi
}

#$1是目录名
test_dir() {
    if [[ ! -d ${log_dir}/$1 ]];then
        mkdir -p ${log_dir}/$1
    fi

    if [[ -d ${install_dir}/$1 ]];then
        test_exit "${install_dir}/${1}目录已经存在，请检查安装脚本路径或手动删除目录" "$ {install_dir}/${1} directory already exists, please check the installation script path or manually delete the directory"
    fi
}

#位置变量皆为软件包名
test_install() { 
    for i in `echo $@`
    do
        rpm -q $i
    
        if [[ $? -ne 0 ]];then
            yum -y install $1
            rpm -q $1
        
            if [[ $? -ne 0 ]];then
                test_exit "${1}软件包找不到，请手动安装" "${1} software package can not find, please manually install"
            fi
        fi
    done
}

#下载效验，$1为包名，$2为网络下载地址，$3为md5值
test_package() {
    local a=0 i

    for i in `ls package/`
    do
        md5sum package/$i | grep ${3} &> /dev/null
        if [ $? -eq 0 ];then
            a=1
            break
        fi
    done
    
    if [ $a -eq 0 ];then
        wget -0 package/${1} $2
        test_package
    fi
}
