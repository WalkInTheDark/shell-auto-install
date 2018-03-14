#!/usr/bin/env bash
#redis-browser，redis的可视化工具


#[使用设置]
#主目录，相当于/usr/local
#install_dir=/ops/server

#日志主目录，相当于/var/log
#log_dir=/ops/log

#服务目录名
redis_browser_dir=redis-browser

#填写redis的主机名节点，最少2个
cluster_name=(service1 service2 service3)
cluster_ip=(192.168.2.108:7000 192.168.2.108:7002 192.168.2.108:7004) 

#redis_browser的端口
port=1212

#redis_browser监听
listen=0.0.0.0



get_redis_browser() {
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
    
    get_redis_browser
    gem update —system
    gem sources —add https://gems.ruby-china.org/ —remove https://rubygems.org/
    gem sources -l
    gem install material/redis-4.0.1.gem
    gem install material/redis-browser-0.5.1.gem
    
    d=1 #名字，从第2个起
    echo "connections:" >> ${install_dir}/${redis_browser_dir}/config.yml
    
    for i in `echo ${cluster_ip[*]}`
    do
        if [ "$i" == "${cluster_ip[0]}" ];then #第一个跳过做默认
            continue
        fi
        
        b=`echo $i | awk -F':' '{print $1}'` 
        c=`echo $i | awk -F':' '{print $2}'`
        cp material/redis_browser.yuml ./one #复制一份格式文件做修改
        
        sed -i "1s/service3:/${cluster_name[$d]}" one
        sed -i "2s/host: 192.168.1.3/host: $b/g" one
        sed -i "3s/port: 7004/port: $c/g" one
        sed -i "5s,url_db_0: redis://192.168.1.3:7004/0,url_db_0: redis://${i}/0,g" one
        cat one >> ${install_dir}/${redis_browser_dir}/config.yml
        let d++
        rm -rf one
    done

    #启动脚本
    test_bin man-redis-browser
    sed -i "2a port=${port}" $command
    sed -i "3a listen=${listen}" $command
    sed -i "4a install_dir=$install_dir" $command
    sed -i "5a log_dir=$log_dir" $command
    sed -i "6a redis_browser_dir=$redis_browser_dir" $command
    sed -i "7a one=${cluster_ip}" $command

    #测试
    
    
    clear
    echo "install ok
        
install_dir=${install_dir}/${redis_browser_dir}

log_dir=${log_dir}/${redis_browser_dir}

bin=/usr/local/bin/man-redis-browser

man-redis-browser start

curl http://127.0.0.1:${port}"
}

info_redis_browser() {
        echo "Name：redis-browser
        
version：0.5.1

Introduction：安装redis-browser"
}
