#!/usr/bin/env bash
language=`cat conf/lang.txt`



load() {
    for i in `ls lib`
    do
        source lib/$i
    done
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
    if [ -f script/${2}.sh ];then
        source script/${2}.sh
        
        if [ "$1" == "install" ];then
            test_root
            test_www www.baidu.com
            install_${2}
        elif [ "$1" == "remove" ];then
            remove_${2}
        elif [ "$1" == "get" ];then
            get_${2}
        elif [ "$1" == "edit" ];then
            vi script/${2}.sh
        else
            help_all
        fi
    else
        test_exit "没有这个服务" "Without this service"
    fi
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



#主体
load

if [ "$#" -eq 0 ];then
    help_all
elif [ "$#" -eq 1 ];then
    if [ "$1" == "list" ];then
        list_all
    elif [ "$1" == "help" ];then
        help_all
    else
        help_all
    fi
elif [ "$#" -eq 2 ];then
    if [ "$1" == "lang" ];then
        lang $2
    else
        server $1 $2
    fi
fi
