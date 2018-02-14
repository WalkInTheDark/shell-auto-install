#!/usr/bin/env bash
language=`cat conf/lang.txt`



master_dir() { #可修改
    install_dir=/ops/server
    log_dir=/ops/log
}

load() {
    for i in `ls lib`
    do
        source lib/$i
    done
}

lang() {
    if [ $1 -eq 1 ];then
        echo "1" > conf/lang.txt
    elif [ $1 -eq 2 ];then
        echo "2" > conf/lang.txt
    else
        test_exit "选项错误" "Wrong option"
    fi
}

help_all() {
    [ $language -eq 1 ] && cat conf/zhong_help.txt || cat conf/ying_help.txt
    echo
}

list_all() {
    [ $language -eq 1 ] && echo "没有版本号的，皆为扩展" || echo "No version number, are all extensions"
    cat conf/server_name.txt
    echo
}

server() {
    local a=`process_bian $2`

    if [ -f script/${a}.sh ];then
        source script/${a}.sh
        
        if [ "$1" == "install" ];then
            test_root
            test_www www.baidu.com
            install_${a}
        elif [ "$1" == "remove" ];then
            remove_${a}
        elif [ "$1" == "get" ];then
            get_${a}
        elif [ "$1" == "info" ];then   
            info_${a}
        elif [ "$1" == "edit" ];then
            vi script/${a}.sh
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

if [ "$#" -eq 0 ];then
    help_all
elif [ "$1" == "list" ];then 
    if [ $# -eq 1  ];then
        list_all
    else
        [ $language -eq 1 ] && echo "$2 相关脚本：" || echo "$2 Related script"
        grep $2 conf/server_name.txt
    fi
elif [ "$1" == "type" ];then
    if [ $# -eq 1 ];then
        echo "servre system-man game"
    else
        [ $language -eq 1 ] && echo "$2 相关类型脚本：" || echo "$2 Related type script"
        grep -w $2 conf/server_name.txt
    fi
elif [ "$1" == "help" ];then
    help_all
elif [ "$1" == "lang" ];then
    lang $2
else
    server $1 $2
fi
