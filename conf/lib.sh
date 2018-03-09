#!/usr/bin/env bash



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
        c=`md5sum package/$b | awk '{print $1}'`
        [ "$c" == "$2" ] && a=1 || rm -rf package/$b
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

#$1为字符，会将字符中的-变成_
process_bian() {
    local a="" i b
    for i in `seq 1 ${#1}`
    do
        b=`echo $1 | cut -c $i`
        [ "$b" == "-" ] && a=`echo ${a}_` || a=`echo ${a}${b}`
    done
    echo $a
}

#集群使用，根据本地ip算出id号，统一cluster_ip，返回他在数组第几号
process_id() {
 	local num=`echo ${#cluster_ip[*]}` id a=1 i e
    	let num--

	for i in `ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\."`
	do
		[ $a -eq 0 ] && break
		for e in `seq 0 $num`
		do
            		echo ${cluster_ip[$e]} | grep $i &> /dev/null
        		if [ $? -eq 0 ];then
               			id=$e
				a=0
                		break
        		fi
        	done
    	done
	
	let id++
	echo $id
}

#集群使用，根据本地ip算出当前绑定ip，统一cluster_ip，返回绑定ip
process_ip() {
 	local num=`echo ${#cluster_ip[*]}` ip a=1 i e
    	let num--

	for i in `ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\."`
	do
		[ $a -eq 0 ] && break
		for e in `seq 0 $num`
		do
            		echo ${cluster_ip[$e]} | grep $i &> /dev/null
        		if [ $? -eq 0 ];then
               			ip=$i
				a=0
                		break
        		fi
        	done
    	done
	echo $ip
}
