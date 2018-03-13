#!/usr/bin/env bash
#jenkins基本环境


#[使用设置]
#主目录，相当于/usr/local
#install_dir=/ops/server

#日志主目录，相当于/var/log
#log_dir=/ops/log

#服务目录名
jenkins_dir=jenkins



get_jenkins() {
    test_package jenkins.war http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/jenkins.war
    
    test_package https://raw.githubusercontent.com/goodboy23/shell-script/master/conf/man-jenkins
}

install_jenkins() {
    test_dir $jenkins_dir
    
    #安装依赖和包
    bash sai.sh install jdk-eight
    get_jenkins
    cp package/jenkins.war ${install_dir}/${jenkins_dir}/
    
    #配置启动脚本
    command=/usr/local/bin/man-jenkins
    rm -rf $command
    cp conf/jenkins/man-jenkins $command
    chmod +x $command

    sed -i "2a install_dir=$install_dir" $command
    sed -i "3a log_dir=$log_dir" $command
    sed -i "4a jenkins_dir=$jenkins_dir" $command
    
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
