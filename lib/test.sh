#!/usr/bin/env bash
#test组  测试，不成功将给出返回值，或者退出报错



#提示并退出脚本，$1中文，$2英文
test_exit() {
if [[ $language -eq 1 ]];then
    clear
    echo
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo 错误：$1
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo
    exit
else
    clear
    echo
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo 错误：$2
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo
    exit
fi
}

#系统是64位则返回0
test_64bit(){
    if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
        return 0
    else
        return 1
    fi
}

#测试是否是root
test_root(){
    if [[ $EUID -ne 0 ]]; then
        test_exit "这个脚本必须以root身份运行" "This script must be run as root"
    fi
}

#测试网站是否正常，$1为网址
test_www() {
    local a=`curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1`
    [ $a -eq 200 ] || test_exit "无法访问外网，请重试或者调试网络" "Unable to access external network, please try again or debug network" 
}

#测试输入的是否为ip，$1填写ip
test_ip() {
    local status=$(echo $1|awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}')
    if echo $1|grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$">/dev/null;
then
	if [ status == "yes" ]; then
		return 0
	else
		return 1
	fi
else
	return 1
fi
}

#测试主目录是否存在
test_dir_master() {
    if [[ ! -d ${install_dir} ]];then
        mkdir -p ${install_dir}
    fi
}

#创建日志目录，并检测服务目录，$1是目录名
test_dir() {
    if [[ ! -d ${log_dir}/$1 ]];then
        mkdir -p ${log_dir}/$1
    fi

    if [[ -d ${install_dir}/$1 ]];then
        test_exit "${install_dir}/${1}目录已经存在，请检查安装脚本路径或手动删除目录" "$ {install_dir}/${1} directory already exists, please check the installation script path or manually delete the directory"
    fi
}

#位置变量皆为软件包名
test_install() {
    yum -y install $@
    for i in `echo $@`
    do
        rpm -q $i
        [ $? -eq 0 ] || test_exit "${1}软件包找不到，请手动安装" "${1} software package can not find, please manually install"
    done
}

#扩展服务使用，$1写必须安装的服务名
test_rely() {
    bash sai.sh list installed | grep "^${1}"
    [ $? -ne 0 ] && bash sai.sh install $1
}

#下载安装包，$1为网络下载地址，$2为md5值
test_package() {
    local a=0 b=`echo ${1##*/}` c i

    if [ -f package/$b ];then
        c=`md5sum package/$b`
        [ "$c" == "$2" ] && a=1 || rm -rf package/$b
    else
    	[ $language -eq 1 ] && echo "下载完成" || echo "Download completed"
	a=1
    fi
    
    if [ $a -eq 0 ];then
        test_www www.baidu.com
        wget -O package/${b} $1
        test_package $1 $2 #验证
    fi
}

test_remove() {
    [ $language -eq 1 ] && read -p "确定删除[y/n]：" yn || read -p "OK to delete [y/n]：" yn
    if [ "$yn" != "y" ];then
       exit
    fi
}
