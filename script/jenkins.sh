#!/usr/bin/env bash



#[使用设置]
#主目录，相当于/usr/local
#install_dir=/ops/server

#日志主目录，相当于/var/log
#log_dir=/ops/log

#服务目录名
jenkins_dir=jenkins



get_jenkins() {
        test_package jenkins.war http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/jenkins.war

    if [ ! -n "$1" ];then
        [ $language -eq 1 ] && echo "下载完成" || echo "Download completed"
    fi
}

install_jenkins() {
    test_install java-1.8.0-openjdk
    test_dir_master
    test_dir $jenkins
    
    package=`get_jenkins 1`
    cp package/${package} ${install_dir}/${jenkins_dir}/
    
    command=/usr/local/bin/man-jenkins
    cp conf/jenkins/man-jenkins $command
    chmod +x $command

    sed -i "2a install_dir=$install_dir" $command
    sed -i "3a log_dir=$log_dir" $command
    sed -i "4a jenkins_dir=$jenkins_dir" $command

    echo "jenkins" >> conf/installed.txt
    
    clear
    [ $language -eq 1 ] && echo "jenkins安装完毕，浏览器输入http://127.0.0.1:8080登陆jenkins" || echo "jenkins installation is completed,Browser input http://127.0.0.1:8080 landing jenkins"
}

remove_jenkins() {
    man-jenkins stop
    rm -rf /usr/local/bin/man-jenkins
    rm -rf ${install_dir}/${jenkins_dir}
    
    [ $language -eq 1 ] && echo "jenkins已卸载" || echo "jenkins Uninstalled"
}

info_jenkins() {
    if [ $language -eq 1 ];then
        echo "名字：jenkins
        
版本：2.104

介绍：安装jenkins

作者：book

提示：可以配置安装地址

使用：浏览器输入http://127.0.0.1:8080登陆jenkins"
    else
        echo "Name：jenkins
        
version：2.104

Introduction：Install jenkins, persistence and integration tools

Author：book

Prompt：You can configure the installation address

use：Browser input http://127.0.0.1:8080 landing jenkins"
    fi
}
