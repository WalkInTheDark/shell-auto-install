# shell-auto-install

## 简介
shell自动安装，简称sai，类似centos的yum或者ubuntu的apt命令

可以快速，准确的安装各种服务，集群，可视化工具和其他类型脚本

sai不是单纯的一键安装脚本，它是脚本管理平台，让脚本编写简单并格式化

## 优点
支持中英文显示

可以用./sai.sh info mine的方式查询这个脚本的详细信息和介绍

可以用./sai.sh get  mine的方式预先下载安装所需要的包，以后可以离线安装

脚本有大量效验，防止大部分的误操作和安装环境问题

当不符合脚本要求时,会退出并提示如何解决，解决后再次安装即可

某些服务部署后会产生man-系列的管理脚本中，方便对服务启动关闭和个性化设置

## 相比其它一键脚本
有shell函数库，编写和调整将会很轻松，结构也会简单

所有脚本受到sai.sh管理，从而标准化，每个服务都可以安装卸载，并查看详细信息，而不需要看代码

服务之间互相依赖，当前功能不满意，只需要更改少量代码即可

## 使用方法
yum -y install git #安装git

git clone https://github.com/goodboy23/shell-auto-install.git #下载包

cd shell-auto-install #移动到包中，以后使用也是到包中

chmod +x sai.sh #给脚本增加执行权限

./sai.sh #查看帮助

## 更新方法
cd shell-auto-install

./sai.sh update

## 查看帮助

 ![xx](https://github.com/goodboy23/shell-auto-install/blob/master/package/a.png)

## 安装使用

![dd](https://github.com/goodboy23/shell-auto-install/blob/master/package/b.png)
