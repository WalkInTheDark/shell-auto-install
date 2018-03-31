#!/usr/bin/env bash



#[使用设置]

#设置显示语言，cn为中文，en为英文
language=en

#全局安装目录
install_dir=/usr/local
    
#全局日志目录
log_dir=/var/log

#edit选项的编辑器，可选择vim或其他
editor=vi

#是否允许把使用次数发送到互联网，用于统计，默认ok，选择其他则不发送
log=ok



#用于使用记录的统计，想知道多少人在使用sai /笑脸
fa_log() {
	curl http://www.52wiki.cn/docs/saitest?token=88h1354nP0gK &> /dev/null
}

#中文帮助
help_cn() {
	echo "提示：所有服务默认安装！ 如果您自定义安装位置或其他设置，请编辑服务名称
当前版本：1.0

install httpd        安装 httpd
remove  httpd        卸载 httpd
get     httpd        离线 httpd 所需要的包
info    httpd        查询 httpd 详细信息
edit	httpd        编辑 httpd 进行自定义设置

update               升级 sai
installed            列出 已安装 服务

list                 列出 支持  的脚本
list    httpd        列出 httpd 相关脚本"
}

#英文帮助
help_en() {
    echo "Tip: All services are installed by default! If you customize the installation location or other settings, please edit the service name
current version：1.0

install httpd      installation httpd
remove  httpd      Uninstall    httpd
get     httpd      Required     httpd packages for offline
info    httpd      Query        httpd details
edit	httpd      Edit         httpd for custom settings

update             update sai
installed          List installed services

list               List supported scripts
list    httpd      List httpd related scripts"
}

#删除当前安装包以外文件，下载新sai，将其中全部文件放到当前
update_sai() {
    test_root
    test_install git
    ls | grep -v package | xargs rm -rf
    git clone https://github.com/goodboy23/shell-auto-install.git
    rm -rf shell-auto-install/package
    mv shell-auto-install/* .
    rm -rf shell-auto-install
    chmod +x sai.sh
    clear
    [ "$language" == "cn" ] && echo "升级成功！" || echo "update ok!"
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
        awk 'BEGIN{printf "%-20s%-20s%-20s\n","'"$name"'","'"$version"'","'"$intr"'";}' >> conf/list_${language}.txt
        echo " " >> conf/list_${language}.txt
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
			grep "^${2}" conf/installed.txt &> /dev/null
			[ $? -eq 0 ] && test_exit "${2}已安装" "${2} is already installed"
            [ "$language" == "cn" ] && echo "正在安装${2}，在安装过程中发生错误，它将退出并提供解决方案" || echo "Installing ${2}, an error occurred during installation, it will exit and give a solution"
            sleep 3
            install_${a}
		elif [ "$1" == "remove" ];then
			remove_${a}
        elif [ "$1" == "get" ];then
            get_${a}
        elif [ "$1" == "info" ];then   
            info_${a}
        elif [ "$1" == "edit" ];then
            $editor script/${a}.sh
        else
            [ "$language" == "cn" ] && help_cn || help_en
        fi
    else
        test_exit "没有这项服务" "Without this service"
    fi
}



#主体
for i in `ls lib/*`
do
    source $i
done

[ "$log" == "ok" ] && fa_log

if [ $# -eq 0 ];then
    [ "$language" == "cn" ] && help_cn || help_en
elif [ $# -eq 1 ];then
    if [ "$1" == "list" ];then
        [ -f conf/list_${language}.txt ] || list_generate
        cat conf/list_${language}.txt
    elif [ "$1" == "update" ];then
        update_sai
	elif [ "$1" == "installed" ];then
		cat conf/installed.txt
    fi
elif [ $# -eq 2 ];then
    if [ "$1" == "list" ];then
        [ "$language" == "cn" ] && echo "$2相关脚本：" || echo "$2 Related script："
		grep "^$2" conf/list_${language}.txt
    else
        server $1 $2
    fi
fi
