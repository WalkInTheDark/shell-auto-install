# shell-auto-install

## 简介
支持中英文

shell自动安装，简称sai，类似centos的yum或者ubuntu的apt命令

可以一键安装服务，集群，其它类型脚本，可视化工具

sai可以对所支持的所有服务进行安装，查看，卸载，自定义编辑

当不符合脚本要求时,会退出并提示如何解决，解决后再次安装即可


## 使用方法
yum -y install git #安装git

git clone https://github.com/goodboy23/shell-auto-install.git #下载包

cd shell-auto-install #移动到文件夹中，以后使用也是到此文件夹

chmod +x sai.sh #给脚本增加执行权限

./sai.sh #查看帮助

## 更新方法
cd shell-auto-install

./sai.sh update

## 查看帮助

 ![xx](https://github.com/goodboy23/shell-auto-install/blob/master/package/c.png)

## 安装使用

![dd](https://github.com/goodboy23/shell-auto-install/blob/master/package/d.png)
