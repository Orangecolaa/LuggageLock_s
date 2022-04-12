# 列车智能行李锁管理系统

这是我的个人毕业设计，一个基于Django框架的列车智能行李锁管理系统后台。

<br />

## ✨ 如何使用

```bash
$ # 获取
$ git clone https://github.com/Orangecolaa/LuggageLock.git
$ cd LuggageLock
$
$ # Virtualenv模块安装（基于Linux的系统）
$ virtualenv env
$ source env/bin/activate
$
$ # Virtualenv模块安装（基于Windows的系统）
$ virtualenv env
$ source env\Scripts\activate
$
$ # 安装模块（Windows选-win，Linux选-linux）
$ pip3 install -r requirements-linux.txt
$ # 使用MySQL数据库则导入SQL文件创建表格
$ 
$ # 使用原始的SQLite3数据库则不用
$ # 迁移数据表
$ python manage.py makemigrations
$ python manage.py migrate
$
$ # 创建超级用户
$ python manage.py createsuperuser
$
$ # 启动应用程序（开发模式）
$ python manage.py runserver # default port 8000
$
$ # 启动应用程序-自定义端口
$ # python manage.py runserver 0.0.0.0:<your_port>
$
$ # 在浏览器中访问web应用: http://127.0.0.1:8000/
$ # 访问http://127.0.0.1:8000/admin 创建api和download_data分组
$ # 将创建的超级用户加入两个组开启数据中心功能
```

<br />

---
