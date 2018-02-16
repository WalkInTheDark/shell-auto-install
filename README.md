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

所有脚本受到sai.sh管理，从而标准化，每个服务都可以安装卸载，并查看详细信息

服务之间互相依赖，当前功能不满意，只需要更改少量代码即可

## 使用方法
yum -y install git

git clone https://github.com/goodboy23/shell-auto-install.git

cd shell-auto-install

chmod +x sai.sh

./sai.sh

以上操作后即可使用，建议多看帮助和使用info查看服务的信息

## 更新方法
cd shell-auto-install

./sai.sh update

## 截图

### 帮助

 ![xx](https://github.com/goodboy23/shell-auto-install/blob/master/package/QQ%E6%88%AA%E5%9B%BE20180216193838.png)

### 安装

![dd](https://github.com/goodboy23/shell-auto-install/blob/master/package/QQ%E6%88%AA%E5%9B%BE20180216194310.png)

### 使用

![zz](https://github.com/goodboy23/shell-auto-install/blob/master/package/QQ%E6%88%AA%E5%9B%BE20180214140552.png)
