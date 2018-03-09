#!/usr/bin/env bash



#[使用设置]
#主目录，相当于/usr/local
#install_dir=/ops/server

#日志主目录，相当于/var/log
#log_dir=/ops/log

#服务目录名
redis_browser_dir=redis-browser

#填写redis集群的主机名和对应节点，只要主节点
cluster_name=(service1 service2 service3)
cluster_ip=(192.168.2.108:7000 192.168.2.108:7002 192.168.2.108:7004) 



get_redis_browser() {
    bash sai.sh get nodejs
    bash sai.sh get ruby
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/redis-4.0.1.gem" "a4b74c19159531d0aa4c3bf4539b1743"
    test_package "http://shell-auto-install.oss-cn-zhangjiakou.aliyuncs.com/package/redis-browser-0.5.1.gem" "dbe6a5e711dacbca46e68b10466d9da4"
}

install_redis_browser() {
    test_dir_master
    test_dir $redis_browser_dir
    
    test_www www.baidu.com
    
    test_install gem
    bash sai.sh install nodejs
    bash sai.sh install ruby
    
    gem update —system
    gem sources —add https://gems.ruby-china.org/ —remove https://rubygems.org/
    gem sources -l
    gem install package/redis-4.0.1.gem
    gem install package/redis-browser-0.5.1.gem
    
    d=1 #名字，从第2个起
    echo "connections:" >> ${install_dir}/${redis_browser_dir}/config.yml
    
    for i in `echo ${cluster_ip[*]}`
    do
        if [ "$i" == "${cluster_ip[0]}" ];then #第一个跳过做默认
            continue
        fi
        
        b=`echo $i | awk -F':' '{print $1}'` 
        c=`echo $i | awk -F':' '{print $2}'`
        cp conf/redis/redis_browser.yuml ./one #复制一份格式文件做修改
        
        sed -i "1s/service3:/${cluster_name[$d]}" one
        sed -i "2s/host: 192.168.1.3/host: $b/g" one
        sed -i "3s/port: 7004/port: $c/g" one
        sed -i "5s,url_db_0: redis://192.168.1.3:7004/0,url_db_0: redis://${i}/0,g" one
        cat one >> ${install_dir}/${redis_browser_dir}/config.yml
        let d++
        rm -rf one
    done

    command=/usr/local/bin/man-redis-browser
    cp conf/redis/man-redis-browser $command
    chmod +x $command

    sed -i "2a install_dir=$install_dir" $command
    sed -i "3a log_dir=$log_dir" $command
    sed -i "4a redis_browser_dir=$redis_browser_dir" $command
    sed -i "5a one=${cluster_ip}" $command

    echo "redis-browser" >> conf/installed.txt
    
    clear
    if [ $language -eq 1 ];then
    echo "redis-browser安装成功，使用man-redis-browser管理
        
安装目录：${install_dir}/${redis_browser_dir}

日志目录：${log_dir}/${redis_browser_dir}

浏览器输入 http://127.0.0.1:1212登陆"
    else
        echo "redis-browser installed successfully, using man-redis-browser management
        
installation manual：${install_dir}/${redis_browser_dir}

Log directory：${log_dir}/${redis_browser_dir}

Browser enter http://127.0.0.1:1212 login"
    fi
}

remove_redis_browser() {
    man-redis-browser stop
    rm -rf /usr/local/bin/man-redis-browser
    rm -rf ${install_dir}/${redis_browser_dir}
    
    [ $language -eq 1 ] && echo "redis-browser已卸载" || echo "redis-browser Uninstalled"
}

info_redis_browser() {
    if [ $language -eq 1 ];then
        echo "名字：redis-browser

版本：0.5.1

介绍：安装redis-browser

作者：book

提示：需要修改配置文件，填写redis节点

使用：使用man-redis-browser管理，浏览器输入http://127.0.0.1:1212登陆"
    else
        echo "Name：redis-browser
        
version：0.5.1

Introduction：Install redis-browser, which is a redis visualization tool that can manipulate the database from the web

Author：book

Prompt：Need to modify the configuration file, fill in the redis node

use：Man-redis-browser management，Browser enter http://127.0.0.1:1212 login"
    fi
}
