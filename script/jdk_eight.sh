#!/usr/bin/env bash



#[使用设置]

#主目录，相当于/usr/local
#install_dir=

#服务目录名
jdk_eight_dir=java-1.8



get_jdk_eight() {
    test_package http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/jdk-8u152-linux-x64.tar.gz adfb92ae19a18b64d96fcd9a3e7bfb47
}

install_jdk_eight() {
    test_dir $jdk_eight_dir
    
    #安装服务
    get_jdk_eight
    tar -xf package/jdk-8u152-linux-x64.tar.gz
    mv jdk1.8.0_152 ${install_dir}/${jdk_eight_dir}
    
    #环境变量
    echo "export JAVA_HOME=${install_dir}/${jdk_eight_dir}" >> /etc/profile
    echo "export JRE_HOME=${install_dir}/${jdk_eight_dir}/jre" >> /etc/profile
    echo 'export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib' >> /etc/profile
    echo 'export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH' >> /etc/profile
    
    source /etc/profile
    
    #测试
    java -version
    [ $? -eq 0 ] || test_exit "Installation failed, please check the script"

    clear
        echo "install ok

install_dir=${install_dir}/${jdk_eight_dir}

PATH in /etc/profile"
}

info_jdk_eight() {
    echo "Name：jdk-eight
        
version：1.8.0

Introduction：安装jdk-1.8.0"
}
