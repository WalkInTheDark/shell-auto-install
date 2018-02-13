#!/usr/bin/env bash
#process组 字符文本处理，返回处理后的值
set -u #使用不存在变量将退出报错

#从位置变量中找出是数字的部分
process_number() {
    local a=() b=0 c d i

    for i in `echo $@`
    do
        c=`echo ${i%%.*}`
        d=`echo ${i#*.}`
    
        if [[ $d == $c ]];then
            [[ $c -gt 0 ]] &> /dev/null && a[$b]=$i && let b++ && continue
        else
            [[ $c -gt 0 ]] &> /dev/null && [[ $d -gt 0 ]] &> /dev/null && a[$b]=$i && let b++
        fi
    done

    echo "${a[*]}"
}

#从位置变量中找出整数部分
process_integer() {
    local a=() i

    for i in `echo $@`
    do
            [[ $i -gt 0 ]] &> /dev/null && a[$b]=$i
    done

    echo "${a[*]}"
}

#从位置变量中挑出最小值
process_small(){
    echo "$@" | tr " " "\n" | sort -V | head -n 1
}

#从位置变量中挑出最大值
process_big() {
    echo "$@" | tr " " "\n" | sort -rV | head -n 1
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

#把$1汉字转成encode格式
process_encode() {
    echo 论坛 | tr -d "\n" | xxd -i | sed -e "s/ 0x/%/g" | tr -d " ,\n"
}

#转换大小写，$1为字符串，$2为1则大转小，为2则小转大，默认1
process_capital() {
    local a=1
    [ ! $a ] && a=1 || c=$2
    if [ $a -eq 1 ];then 
        echo $1 | tr "[A-Z]" "[a-z]"
    elif [ $a -eq 2 ];then
        echo $1 | tr "[a-z]" "[A-Z]"
    else
        return 1
    fi
}



#一个随机端口号
process_port() {
    shuf -i 9000-19999 -n 1
}

#随机密码，位置变量1可指定密码长度，默认6位
process_passwd(){
    local a=0 b="" c=6
    [ ! $1 ] && c=6 || c=$1
    
    for i in {a..z}; do arr[a]=${i}; a=`expr ${a} + 1`; done
    for i in {A..Z}; do arr[a]=${i}; a=`expr ${a} + 1`; done
    for i in {0..9}; do arr[a]=${i}; a=`expr ${a} + 1`; done
    for i in `seq 1 $c`; do b="$b${arr[$RANDOM%$a]}"; done
    echo ${b}
}



#一排横线，$1可指定长度，默认70
process_line() {
    local a=70
    [ ! $1 ] && a=70 || c=$1
    
    printf "%-${a}s\n" "-" | sed 's/\s/-/g'
}

#等待，打任意字结束，ctl+c将退出脚本
process_char(){
    SAVEDSTTY=`stty -g`
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

