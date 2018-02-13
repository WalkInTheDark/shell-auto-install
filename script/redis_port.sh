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

    [ -d ${install_dir}/${redis_dir} ] || test_exit "请先安装redis" "Please install redis"

    error_port="" #存储有问题的端口
    for i in `echo ${port[*]}`
    do
        #先检查端口是否被占用
        netstat -unltp | awk -F':' '{print $2}' | grep -w $i &> /dev/null
        if [ $? -eq 0 ];then
            error_port=`echo $error_port $i`
            continue
        fi
        
        command=/usr/local/bin/redis-man
        if [ ! -f $command ];then
            cp conf/redis/redis-man.sh $command
        
            sed -i "2a install_dir=${install_dir}" $command
            sed -i "3a log_dir=${log_dir}" $command
            sed -i "4a redis_dir=${redis_dir}" $command
        
            chmod +x $command
        fi
        
        #再检查是否和-man系列管理脚本记录冲突
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
        [ ${#error_port} -gt 0 ] && echo "错误：$error_port 端口被占用，无法创建"
        echo
        echo "使用redis-man命令来管理这些端口实例"
    else
        clear
        [ ${#error_port} -gt 0 ] && echo "error: $error_port ports are occupied and can not be created "
        echo
        echo "Use the redis-man command to manage these port instances"
    fi
}



remove_redis_port() {
    [ -f /usr/local/bin/redis-man ] && sou_port=`redis-man -p` || test_exit "redis-man不存在" "redis-man does not exist"
    local des_port=() i a=0
    
    for i in `echo ${port[*]}`
    do
        for e in `echo $sou_port` #和已存端口进行比对
        do
            echo e | grep -w ${i} &> /dev/null
            if [ $? -eq 0 ];then
                redis-man stop $i
                rm -rf ${install_dir}/${redis_dir}/cluster/${i}
            else
                des_port[a]=$i
                let a++
            fi  
        done  
    done
    
    sed -i "/^port=/cport=(${des_port})" /usr/local/bin/redis-man 

    [ $language -eq 1 ] && echo "redis ${port[*]} 端口已卸载" "redis ${port[*]} port Uninstalled" 
}
