#!/usr/bin/env bash



get_ruby() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_ruby() {
    test_www www.baidu.com

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable

    rvm install 2.4.1
    rvm use 2.4.1 --default

    echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc
    echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db

    echo "ruby" >> conf/installed.txt
    if [ $language -eq 1 ];then
        clear
        echo "ruby安装完成"
        echo
        echo "环境变量设置完毕，请退出当前终端后重新进入"
    else
    clear
        echo "ruby installation is complete"
        echo " "
        echo "Environment variable is set, please exit the current terminal and re-enter"
    fi
}

remove_ruby() {
    rvm remove 2.4.1
    rm -rf /etc/profile.d/rvm.sh
    rm -rf /usr/local/rvm
    
    [ $language -eq 1 ] && echo "rvm已卸载" "rvm Uninstalled" 
}

info_ruby() {
    if [ $language -eq 1 ];then
        echo "名字：ruby
        
类型：语言

版本：2.4.1

作者：book

介绍：ruby语言安装

提示：使用rvm进行安装

使用：无"
    else
        echo "Name：ruby
        
Type：lang

version：2.4.1

Author：book

Introduction：ruby language installation

Prompt：Use rvm to install

use：no"
    fi
}
