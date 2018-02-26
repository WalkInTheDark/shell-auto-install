#!/usr/bin/env bash
language=`cat conf/lang.txt`



#[实用设置]

#安装目录
install_dir=/ops/server
    
#日志目录
log_dir=/ops/log
    
#edit选项的编辑器，可选择vim或其他
ditor=vi



#加载函数
load() {
    for i in `ls lib`
    do
        source lib/$i
    done
}

#显示帮助
help_all() {
    [ $language -eq 1 ] && cat conf/zhong_help.txt || cat conf/ying_help.txt
}

#将已安装记录从list表中查找
list_all() {
    if [ "$1" == "installed" ];then
        for i in `cat conf/installed.txt`
        do
            grep "^${i}" conf/${server_name} | head -1
        done
    else
        [ $language -eq 1 ] && echo "$1 相关脚本：" || echo "$1 Related script："
        grep "^$1" conf/${server_name}
    fi
}

#生成list表
list_generate() {
    for i in `ls script/`
    do
        #i=`echo ${i%%.*}`
        a=`bash sai.sh info $i | awk  -F'：' '{print $2}' | sed -n '1p'`
        b=`bash sai.sh info $i | awk  -F'：' '{print $2}' | sed -n '3p'`
        c=`bash sai.sh info $i | awk  -F'：' '{print $2}' | sed -n '5p'`
        d=`bash sai.sh info $i | awk  -F'：' '{print $1}' | sed -n '3p'`
        [ "$d" == "依赖" -o "$d" == "rely" ] && b=" " #依赖则不显示版本
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

#升级sai
up() {
    test_install git #是否安装git
    test_www www.baidu.com #是否连接外网

    local c=`cat conf/installed.txt` #将已安装文件读取
    local old_ver=`cat conf/version.txt`
    local new_ver=`curl https://raw.githubusercontent.com/goodboy23/shell-auto-install/master/conf/version.txt`
    local ver=`process_big $old_ver $new_ver` #得出最大值

    if [ "$ver" != "$old_ver" ];then #如果最大值和当前版本一致，将不更新
        cd ..
        git clone https://github.com/goodboy23/shell-auto-install.git temporary
        if [ -d temporary ];then
            rm -rf shell-auto-install
            mv temporary shell-auto-install
            echo $c >> shell-auto-install/conf/installed.txt
            
            [ $language -eq 1 ] && echo "更新完成" || echo "update completed"
        else
            [ $language -eq 1 ] && echo "更新失败" || echo "Update failed"
        fi
    else
        [ $language -eq 1 ] && echo "版本一致，不用更新" || echo "The same version, without updating"
    fi
}

#对于服务的操作
server() {
    local a=`process_bian $2` #将-变成_，方便调用

    if [ -f script/${a}.sh ];then
        source script/${a}.sh
        if [ "$1" == "install" ];then
            test_root
            
            grep "^${a}" conf/installed.txt &> /dev/null
            [ $? -eq 0 ] && test_exit "${a}已安装" "${a} is already installed"
            
            [ $language -eq 1 ] && echo "请等待安装，安装后会出现完成信息，安装出现错误，将会退出并给出解决办法。" || echo "Please wait for the installation, the installation will be completed after the completion of information, installation error, will exit and give a solution."  
            sleep 1
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

a=`cat conf/lang.txt`
server_name=list_${a}.txt #如语言改变，则生成新表
[ -f conf/${server_name} ] || list_generate


if [ $# -eq 0 ];then
    help_all
elif [ $# -eq 1 ];then
    if [ "$1" == "list" ];then
        cat conf/${server_name}
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
