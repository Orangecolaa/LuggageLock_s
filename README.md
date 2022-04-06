# 列车智能行李锁管理系统

这是我的个人毕业设计，一个列车智能行李锁管理系统后台。

<br />

## ✨ 如何使用

```bash
$ # 获取
$ git clone https://github.com/Orangecolaa/LuggageLock.git
$ cd LuggageLock
$
$ # Virtualenv modules installation (Unix based systems)
$ virtualenv env
$ source env/bin/activate
$
$ # Virtualenv modules installation (Windows based systems)
$ virtualenv env
$ .\env\Scripts\activate
$
$ # Install modules
$ # SQLIte version
$ pip3 install -r requirements.txt
$
$ # Create tables
$ python manage.py makemigrations
$ python manage.py migrate
$
$ # Start the application (development mode)
$ python manage.py runserver # default port 8000
$
$ # Start the app - custom port 
$ # python manage.py runserver 0.0.0.0:<your_port>
$
$ # Access the web app in browser: http://127.0.0.1:8000/
```

> 注意：要使用该应用程序，请访问注册页面并**创建一个新用户**。认证后，应用程序将解锁私人页面。

<br />

---
