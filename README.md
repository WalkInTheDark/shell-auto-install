# shell-auto-install

## 简介
支持中英文

shell自动安装，简称sai，类似centos的yum或者ubuntu的apt命令

可以一键安装服务，集群，其它类型脚本，可视化工具

sai可以对所支持的所有服务进行安装，查看，卸载，自定义编辑

当不符合脚本要求时,会退出并提示如何解决，解决后再次安装即可

## 注意事项
请先进行测试后，再在生产或其他重要场合使用。

当前只支持centos7

当前脚本需要Linux入门知识

## 使用方法

[下载地址](https://github.com/goodboy23/shell-auto-install/releases "下载地址")

下载后
tar -xf sai.tar.gz

cd shell-auto-install

chmod +x sai.sh

./sai.sh

## 使用自定义安装包

如果想使用其他版本的mysql等服务的安装包，可以将安装包放到package文件夹中

再使用./sai.sh edit mysql 将get_mysql函数中网址部分替换为安装包名，md5部分替换为相应md5值

可能需要修改脚本的安装步骤

## 设置中文

默认是英文，vim sai.sh 可以修改全局的安装目录，中英文显示

![](http://www.52wiki.cn/uploads/201803/shell/attach_1520aa59400f0727.png)

## 查看帮助

![](http://www.52wiki.cn/uploads/201803/shell/attach_1520aa578d4a5b68.png)

## 查看列表

列表分为3部分，应用名，版本，介绍

![](http://www.52wiki.cn/uploads/201803/shell/attach_1520aa553ba217c0.png)

## 安装使用

![](http://www.52wiki.cn/uploads/201803/shell/attach_1520aa5cb4ad6362.png)
