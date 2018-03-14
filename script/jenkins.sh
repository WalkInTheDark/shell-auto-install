#!/usr/bin/env bash
#jenkins基本环境


#[使用设置]
#主目录，相当于/usr/local
#install_dir=/ops/server

#日志主目录，相当于/var/log
#log_dir=/ops/log

#服务目录名
jenkins_dir=jenkins

#开启的端口号
port=8080

#默认监听所有
listen=0.0.0.0



get_jenkins() {
    test_package jenkins.war http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/jenkins.war
}

install_jenkins() {
    test_dir $jenkins_dir
    
    #安装依赖和包
    bash sai.sh install jdk-eight
    get_jenkins
    mkdir ${install_dir}/${jenkins_dir}
    cp package/jenkins.war ${install_dir}/${jenkins_dir}/
    
    #配置启动脚本
    test_bin man-jenkins

    sed -i "2a port=$port" $command
    sed -i "3a listen=$listen"
    sed -i "4a install_dir=$install_dir" $command
    sed -i "5a log_dir=$log_dir" $command
    sed -i "6a jenkins_dir=$jenkins_dir" $command

    #完成
    clear
    echo "install ok
    
install_dir=${install_dir}/${jenkins_dir}

log_dir=${log_dir}/${jenkins_dir}

bin=/usr/local/bin/man-jenkins

Start：man-jenkins start

Test：curl http://127.0.0.1:8080"
}

info_jenkins() {
    echo "Name：jenkins
        
version：2.104

Introduction：安装jenkins基本"
}