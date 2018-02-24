#!/usr/bin/env bash
#test组  测试，不成功将给出返回值，或者退出报错



#位置变量1是中文，位置变量2是英文
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

#关闭各种墙
test_wall(){
    if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
        sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
        setenforce 0
    fi
}

#测试主目录是否存在
test_dir_master() {
    if [[ ! -d ${install_dir} ]];then
        mkdir -p ${install_dir}
    fi
}

#$1是目录名
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
    yum -y install $@ &> /dev/null
    for i in `echo $@`
    do
        rpm -q $i &> /dev/null
        [ $? -eq 0 ] || test_exit "${1}软件包找不到，请手动安装" "${1} software package can not find, please manually install"
    done
}

#下载效验，$1为包名，$2为网络下载地址，最后返回正确包名
test_package() {
    local a=0 i

    for i in `ls package/`
    do
        if [ "$i" == "$1" ];then
            echo $1
	    a=1
            break
        fi
    done
    
    if [ $a -eq 0 ];then
        test_www www.baidu.com
        wget -O package/${1} $2 &> /dev/null
        echo $1
    fi
}

#扩展服务使用，$1写必须安装的服务名
test_rely() {
    bash sai.sh list installed | grep "^${1}" &> /dev/null
    [ $? -ne 0 ] && test_exit "请先安装${1}" "Please install ${1}"
}

#集群使用，根据本地ip算出id号，统一cluster_ip，返回他在数组第几号
test_id() {
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
test_ip() {
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
