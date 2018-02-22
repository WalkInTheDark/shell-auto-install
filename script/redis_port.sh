#!/usr/bin/env bash

#请先安装redis，这里只启动端口实例

#[使用设置]
#将安装或卸载以下端口，每次新添加的端口会自动加入到管理脚本
port=(6379)



get_redis_port() {
    source script/redis.sh
    get_redis
}

install_redis_port() {
    source script/redis.sh

    bash sai.sh list installed | grep "^redis" &> /dev/null
    [ $? -ne 0 ] && test_exit "请先安装redis" "Please install redis"
    
    command=/usr/local/bin/man-redis #创建一个管理脚本
    if [ ! -f $command ];then
        cp conf/redis/man-redis $command
        
        sed -i "2a install_dir=${install_dir}" $command
        sed -i "3a log_dir=${log_dir}" $command
        sed -i "4a redis_dir=${redis_dir}" $command
        
        chmod +x $command
    fi

    error_port="" #存储有问题的端口
    for i in `echo ${port[*]}`
    do       
        #检查是否和man-系列管理脚本中对于端口的记录冲突
        sou_port=`bash $command -p`
        echo $sou_port | grep -w ${i} &> /dev/null
        if [ $? -eq 0 ];then
            error_port=`echo $error_port $i`
            continue
        else
            des_port=`echo ${sou_port} ${i}`
            sed -i "/^port=/cport=(${des_port})" $command
        fi
   
        conf=${install_dir}/${redis_dir}/cluster/${i}/${i}.conf
    
        mkdir -p ${install_dir}/${redis_dir}/cluster/${i}
        cp conf/redis/7000.conf $conf
    
        sed -i "/^port/cport ${i}" $conf
        sed -i "/^cluster-config-file/ccluster-config-file nodes_${i}.conf" $conf
        sed -i "/^pidfile/cpidfile redis_${i}.pid" $conf
        sed -i "/^dir/cdir ${install_dir}/${redis_dir}/cluster/${i}" $conf 
    done

    if [ $language -eq 1 ];then
        clear
        [ ${#error_port} -gt 0 ] && echo "错误：$error_port 端口已在管理端记录，无法创建"
        echo
        echo "使用man-redis命令来管理这些端口实例"
    else
        clear
        [ ${#error_port} -gt 0 ] && echo "error: $error_port Port has been recorded in the management, can not be created"
        echo
        echo "Use the man-redis command to manage these port instances"
    fi
}

remove_redis_port() {
    local des_port=() sou_port=`man-redis -p` i e a=0 b=0
    
    for i in `echo ${sou_port[*]}` #端口放进数组
    do
        des_port[a]=$i
        let a++
    done
    
    for i in `echo ${port[*]}` #和已存端口进行比对
    do
        for e in `echo ${des_port[*]}`
        do
            if [ "$i" == "$e" ];then
                man-redis stop $i
                rm -rf ${install_dir}/${redis_dir}/cluster/${i}
                des_port[$b]= #变空
                let b++
            else
                let b++
            fi
        done 
    done
    
    sed -i "/^port=/cport=(${des_port[*]})" /usr/local/bin/redis-man 

    [ $language -eq 1 ] && echo "redis ${port[*]} 端口已卸载" "redis ${port[*]} port Uninstalled" 
}

info_redis_port() {
    if [ $language -eq 1 ];then
        echo "名字：redis-port
        
版本：3.2.9

作者：book

介绍：仅启动实例端口，需要先安装redis

提示：不管安装或卸载端口，都会安装配置文件写的来

使用：man-redis 来查看帮助"
    else
        echo "Name：redis-port
       
version：3.2.9

Author：book

Introduction：Only start the instance port, you need to install redis

Prompt：Whether to install or uninstall the port, will be installed to write the configuration file

use：man-redis to see help"
    fi
}
