# shell-auto-install

## 简介
支持中英文

shell自动安装，简称sai，类似centos的yum或者ubuntu的apt命令

可以一键安装服务，集群，其它类型脚本，可视化工具

sai可以对所支持的所有服务进行安装，查看，卸载，自定义编辑

当不符合脚本要求时,会退出并提示如何解决，解决后再次安装即可


## 使用方法
[下载地址](https://www.linuxidc.com/Linux/2016-05/131538.htm "下载地址")


yum -y install unzip

unzip sai.zip

cd shell-auto-install

chmod +x sai.sh

./sai.sh

## 使用自定义安装包

如果想使用其他版本的mysql等服务的安装包，可以将安装包放到package文件夹中

再使用./sai.sh edit mysql 将get_mysql函数中网址部分替换为安装包名，md5部分替换为相应md5值

## 使用扩展脚本

若mysql等服务不是使用sai安装的，可以使用./sai.sh edit mysql_single 方式，将rely=0修改为rely=1

再使用./sai.sh edit mysql方式，修改安装和日志目录的位置即可

## 查看帮助

 ![xx](https://github.com/goodboy23/shell-auto-install/blob/master/package/c.png)

## 安装使用

![dd](https://github.com/goodboy23/shell-auto-install/blob/master/package/d.png)
