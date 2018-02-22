#!/usr/bin/env bash
language=`cat conf/lang.txt`



#可修改，全局默认安装目录
master_dir() {
    install_dir=/ops/server
    log_dir=/ops/log
}

load() {
    for i in `ls lib`
    do
        source lib/$i
    done
}

help_all() {
    [ $language -eq 1 ] && cat conf/zhong_help.txt || cat conf/ying_help.txt
}

list_all() {
    if [ "$1" == "installed" ];then
        for i in `cat conf/installed.txt`
        do
            grep "^${i}" conf/server_name.txt | head -1
        done
    else
        [ $language -eq 1 ] && echo "$1 相关脚本：" || echo "$1 Related script："
        grep "^$1" conf/server_name.txt
    fi
}

yuyan() {
    if [ $1 -eq 1 ];then
        echo "1" > conf/lang.txt
    elif [ $1 -eq 2 ];then
        echo "2" > conf/lang.txt
    else
        test_exit "选项错误" "Wrong option"
    fi
}

up() {
    test_install git
    test_www www.baidu.com

    local a=`pwd`
    local b=`echo ${a##*/}`
    local c=`cat conf/installed.txt` #将已安装文件读取
    local old_ver=`cat conf/version.txt`
    local new_ver=`curl https://raw.githubusercontent.com/goodboy23/shell-auto-install/master/conf/version.txt`
    local ver=`process_big $old_ver $new_ver` #得出最大值

    if [ "$ver" != "$old_ver" ];then #如果最大值和当前版本一致，将不更新
        cd ..
        git clone https://github.com/goodboy23/shell-auto-install.git temporary
        if [ -d 52wiki.cn ];then
            [ $language -eq 1 ] && echo "更新完成" || echo "update completed"
            rm -rf $b
            mv 52wiki.cn shell-auto-install
            echo $c >> shell-auto-install/conf/installed.txt
        else
            [ $language -eq 1 ] && echo "更新失败" || echo "Update failed"
        fi
    else
        [ $language -eq 1 ] && echo "版本一致，不用更新" || echo "The same version, without updating"
    fi
}

server() {
    local a=`process_bian $2` #将-变成_，统一规划

    if [ -f script/${a}.sh ];then
        source script/${a}.sh
        if [ "$1" == "install" ];then
            test_root
            
            grep "^${a}" conf/installed.txt &> /dev/null
            [ $? -eq 0 ] && test_exit "${a}已安装" "${a} is already installed"
            
            install_${a}
        elif [ "$1" == "remove" ];then
            grep "^${a}" conf/installed.txt &> /dev/null
            [ $? -eq 0 ] && sed -i "/^${a}/d" conf/installed.txt
            sed -i '/^$/d' conf/installed.txt #删除空行
            
            remove_${a}
        elif [ "$1" == "get" ];then
            get_${a}
        elif [ "$1" == "info" ];then   
            info_${a}
        elif [ "$1" == "edit" ];then
            vi script/${a}.sh #可以更换编辑器成vim
        else
            help_all
        fi
    else
        test_exit "没有这个服务" "Without this service"
    fi
}



#主体
load
master_dir

if [ $# -eq 0 ];then
    help_all
elif [ $# -eq 1 ];then
    if [ "$1" == "list" ];then
        cat conf/server_name.txt
    elif [ "$1" == "help" ];then
        help_all
    elif [ "$1" == "update" ];then
        up
    else
        test_exit "没有这个服务" "Without this service"
    fi
elif [ $# -eq 2 ];then
    if [ "$1" == "list" ];then
        list_all $2
    elif [ "$1" == "lang" ];then
        yuyan $2
    else
        server $1 $2
    fi
fi
