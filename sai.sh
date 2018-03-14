#!/usr/bin/env bash



#[使用设置]

#全局安装目录
install_dir=/ops/server
    
#全局日志目录
log_dir=/ops/log
    
#edit选项的编辑器，可选择vim或其他
editor=vi



#英文帮助
help_en() {
    echo "Tip: All services are installed by default! If you customize the installation location or other settings, please edit the service name
current version：1.5.7

install httpd      installation httpd
remove  httpd      Uninstall    httpd
get     httpd      Download     httpd required package
info    httpd      Query        httpd details
edit	httpd      Edit         httpd for custom settings

update             update sai

list               List supported scripts
list    httpd      List httpd related scripts"
}

update_sai() {
    test_root
    test_install git
    ls | grep -v package | xargs rm -rf
    git clone https://github.com/goodboy23/shell-auto-install.git
    rm -rf shell-auto-install/package
    mv shell-auto-install/* .
    rm -rf shell-auto-install
    chmod +x sai.sh
    sai.sh list &> /dev/null
    clear
    echo "update ok!"
}

#生成list表
list_generate() {
    for i in `ls script/`
    do
        i=`echo ${i%%.*}`
        a=`bash sai.sh info $i | awk  -F'：' '{print $2}' | sed -n '1p'`
        b=`bash sai.sh info $i | awk  -F'：' '{print $2}' | sed -n '3p'`
        c=`bash sai.sh info $i | awk  -F'：' '{print $2}' | sed -n '5p'`
        echo "$a:$b:$c" >> conf/a.txt
    done
    sort -n conf/a.txt >> conf/b.txt #排序一下
    
    while read list
    do
        name=`echo $list |awk -F: '{print $1}'`
        version=`echo $list |awk -F: '{print $2}'`
        intr=`echo $list |awk -F: '{print $3}'`
        awk 'BEGIN{printf "%-20s%-20s%-20s\n","'"$name"'","'"$version"'","'"$intr"'";}' >> conf/list.txt
        echo " " >> conf/list.txt
    done < conf/b.txt
    rm -rf conf/a.txt conf/b.txt
}

#对于服务的操作
server() {
    local a=`process_bian $2` #将-变成_，方便调用
    test_root

    if [ -f script/${a}.sh ];then
        source script/${a}.sh
        if [ "$1" == "install" ];then
            echo "Installing ${2}, an error occurred during installation, it will exit and give a solution"
            sleep 3
            install_${a}
        elif [ "$1" == "get" ];then
            get_${a}
        elif [ "$1" == "info" ];then   
            info_${a}
        elif [ "$1" == "edit" ];then
            $editor script/${a}.sh
        else
            help_en
        fi
    else
        test_exit "Without this service"
    fi
}



#主体
for i in `ls lib/*`
do
    source $i
done

if [ $# -eq 0 ];then
    help_en
elif [ $# -eq 1 ];then
    if [ "$1" == "list" ];then
        [ -f conf/list.txt ] || list_generate
        cat conf/list.txt
    elif [ "$1" == "update" ];then
        update
    fi
elif [ $# -eq 2 ];then
    if [ "$1" == "list" ];then
        echo "$1 Related script：" && grep "^$2" conf/list.txt
    else
        server $1 $2
    fi
fi
