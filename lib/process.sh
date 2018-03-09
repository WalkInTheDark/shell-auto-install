#!/usr/bin/env bash
#process组 字符文本处理，返回处理后的值



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
