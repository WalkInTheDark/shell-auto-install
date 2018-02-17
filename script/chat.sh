#!/usr/bin/env bash

get_chat() {
    [ $language -eq 1 ] && echo "不用下载" || ehco "Do not download"
}

install_chat() {
    cp conf/alone/chat /usr/local/bin/chat
    chmod +x /usr/local/bin/chat

    echo "chat" >> conf/installed.txt
    [ $language -eq 1 ] && echo "chat安装完毕，使用chat 开始游戏" || ehco "chat installation is completed, use chat Start the game"
}

remove_chat() {
    rm -rf /usr/local/bin/chat
    [ $language -eq 1 ] && echo "chat已卸载" || ehco "chat Uninstalled"
}


info_chat() {
    if [ $language -eq 1 ];then
        echo "名字：chat
        
类型：游戏

版本：1.0

作者：LingYi

介绍：类似qq的聊天工具，可以远程聊天

提示：对话双方必须指定相同目录

使用：chat /mnt lisi 将会进入等待，等待其他用户进入/mnt将会开始对话
     第一个参数放临时文件，双方必须指定一样的，如果是不同机器，可以用nfs挂载目录
     同一个目录下仅支持2人，q键或ctrl+c退出，一方终止对话，另一方自动关闭
     以“command：”开头的，则在本地执行其后的指令，例如：command：ifconfig ,则会在当前执行ifconfig指令
     以“l say：”开头的，则会将其后指令的执行结果发送给对方。"
    else
        echo "Name：mine
        
Type：game

version：1.0

Author：LingYi

Introduction：Similar qq chat tool, you can chat remotely

Prompt：Both parties to the conversation must specify the same directory

use：chat / mnt lisi will wait, waiting for other users to enter / mnt will start the conversation
     The first parameter temporary files, both sides must specify the same, if it is a different machine, you can use nfs mount directory
     The same directory only supports 2 people, q key or ctrl + c to exit, one to terminate the conversation, the other automatically shut down
     A command that begins with "command:" executes the following command locally, for example: command: ifconfig, the ifconfig command is currently executed
     The "l say:" at the beginning of the implementation of its instructions will be sent to the other side. "
    fi
}
