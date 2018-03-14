#!/usr/bin/env bash
#test组  测试，不成功将给出返回值，或者退出报错



#提示并退出脚本，$1英文
test_exit() {
    clear
    echo
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo Error：$1
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo
    exit
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
        test_exit "This script must be run as root"
    fi
}


#测试网站是否正常，$1为网址
test_www() {
    local a=`curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1`
    [ $a -eq 200 ] || test_exit "Unable to access external network, please try again or debug network" 
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
    [[ ! -d ${install_dir} ]] && mkdir -p ${install_dir}
    
    [[ ! -d ${log_dir}/$1 ]] &&  mkdir -p ${log_dir}/$1

    [[ -d ${install_dir}/$1 ]] && test_exit  "$ {install_dir}/${1} directory already exists, please check the installation script path or manually delete the directory"
}


#位置变量皆为软件包名
test_install() {
    yum -y install $@
    for i in `echo $@`
    do
        rpm -q $i
        [ $? -eq 0 ] || test_exit  "${1} software package can not find, please manually install"
    done
}

#下载安装包，$1为网络下载地址，$2为md5值，md5可以不写
test_package() {
    test_install wget
    local a=0 b=`echo ${1##*/}` c i

    if [ -f package/$b ];then
        if [ ! $2 ];then
            a=1
        else
            c=`md5sum package/$b | awk '{print $1}'`
            [ "$c" == "$2" ] && a=1 || rm -rf package/$b
        fi
    fi
    
    if [ $a -eq 0 ];then
        test_www www.baidu.com
        wget -O package/${b} $1
        test_package $1 $2 #验证
    fi
}
