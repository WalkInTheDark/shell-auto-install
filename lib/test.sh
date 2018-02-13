#!/usr/bin/env bash
#test组  测试，不成功将给出返回值，或者退出报错
set -u #使用不存在变量将退出报错



#系统是64位则返回0
test_64bit(){
    if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
        return 0
    else
        return 1
    fi
}

#测试网络
test_network() {
    ping -c 2 www.baidu.com
    [[ $? -eq 0 ]] || test_exit "无法访问百度，请设置访问外网" "Can not access Baidu, please set to access the Internet"
}

#测试yum是否正常
test_yum(){
    local repolist

    if [[ -f /etc/yum/pluginconf.d/subscription-manager.conf ]];then
        sed -i '/enabled/s/1/0/' /etc/yum/pluginconf.d/subscription-manager.conf
    fi

    yum clean all
    repolist=$(yum repolist 2>/dev/null |awk '/repolist:/{print $2}'|sed 's/,//')
    if [[ $repolist -le 0 ]];then
        test_exit "本机YUM不可用，请正确配置YUM后重试" "The machine YUM is not available, please correct configuration YUM retry"
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
