#!/usr/bin/env bash
#ruby使用rvm来进行安装，可以改ruby版本

#[使用设置]

ruby_version=2.4.1



get_ruby() {
    echo "Do not download"
}

install_ruby() {
    test_www www.baidu.com

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable
    
    #设置环境变量
    echo source /etc/profile.d/rvm.sh >> ~/.bashrc
    source ~/.bashrc
    echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db

    #安装
    rvm install $ruby_version
    rvm use $ruby_version --default
    
    #测试
    ruby --version
    [ $? -eq 0 ] || test_exit "Installation failed, please check the script"
    
    clear
    echo "install ok
    
install_dir=/usr/local/rvm

bin_dir=/etc/profile.d/rvm.sh

PATH in ~/.bashrc"
}

info_ruby() {
    echo "Name：ruby

version：2.4.1

Introduction：安装ruby"
}
