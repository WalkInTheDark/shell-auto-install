#!/usr/bin/env bash



#[使用设置]

#全局安装目录
install_dir=/ops/server
    
#全局日志目录
log_dir=/ops/log
    
#edit选项的编辑器，可选择vim或其他
editor=vi

#读取语言，不用改动
language=`cat conf/lang.txt`



#加载函数
load() {
    for i in `ls lib`
    do
        source lib/$i
    done
}

#中文帮助
help_cn() {
echo "提示：所有服务的安装均为默认设置！若自定义安装位置或其它设置请 edit 服务名
当前版本1.5.7

install httpd      安装 httpd
remove  httpd      卸载 httpd
get     httpd      下载 httpd 所需要的包
info    httpd      查询 httpd 详细信息
edit    httpd      编辑 httpd 进行自定义设置

list               列出 支持  的脚本
list    httpd      列出 httpd 相关脚本
list    installed  列出 所有  已安装脚本

lang    1          设置 语言  为中文
lang    2          设置 语言  为英文"
}

#英文帮助
help_en() {
echo "Tip: All services are installed by default! If you customize the installation location or other settings, please edit the service name
current version：1.5.7

install httpd      installation httpd
remove  httpd      Uninstall    httpd
get     httpd      Download     httpd required package
info    httpd      Query        httpd details
edit	httpd      Edit         httpd for custom settings

list               List supported scripts
list    httpd      List httpd related scripts
list    installed  Lists all installed scripts

lang    1          Set the language to Chinese
lang    2          Set the language to English"
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
        awk 'BEGIN{printf "%-20s%-20s%-20s\n","'"$name"'","'"$version"'","'"$intr"'";}' >> conf/${server_name}
        echo " " >> conf/${server_name}
    done < conf/b.txt
    rm -rf conf/a.txt conf/b.txt
}

#将已安装记录从list表中查找
list_all() {
    if [ "$1" == "installed" ];then
            grep "^${i}" conf/list.txt | head -1
    else
        [ $language -eq 1 ] && echo "$1 相关脚本：" || echo "$1 Related script："
        grep "^$1" conf/server_name
    fi
}

#设置语言
yuyan() {
    if [ $1 -eq 1 ];then
        echo "1" > conf/lang.txt
    elif [ $1 -eq 2 ];then
        echo "2" > conf/lang.txt
    else
        test_exit "选项错误" "Wrong option"
    fi
}

#对于服务的操作
server() {
    local a=`process_bian $2` #将-变成_，方便调用
    test_root

    if [ -f script/${a}.sh ];then
        source script/${a}.sh
        if [ "$1" == "install" ];then
            grep "^${a}" conf/installed.txt &> /dev/null
            [ $? -eq 0 ] && test_exit "${a}已安装" "${a} is already installed"
            
            [ $language -eq 1 ] && echo "正在安装${2}，安装中出现错误，将会退出并给出解决办法" || echo "Installing $ {2}, an error occurred during installation, it will exit and give a solution"  
            sleep 3
            install_${a}
        elif [ "$1" == "remove" ];then
            test_remove
        
            sed -i "/^${a}/d" conf/installed.txt
            sed -i '/^$/d' conf/installed.txt #删除空行
            
            remove_${a}
        elif [ "$1" == "get" ];then
            get_${a}
        elif [ "$1" == "info" ];then   
            info_${a}
        elif [ "$1" == "edit" ];then
            $editor script/${a}.sh
        else
            help_all
        fi
    else
        test_exit "没有这个服务" "Without this service"
    fi
}



#主体
load
server_name=list_${language}.txt #如语言改变，则生成新表

if [ $# -eq 0 ];then
    [ $language -eq 1 ] && help_cn || help_en 
elif [ $# -eq 1 ];then
    if [ "$1" == "list" ];then
        [ -f conf/${server_name} ] || list_generate
        cat conf/${server_name}
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
