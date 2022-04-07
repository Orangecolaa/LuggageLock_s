# -*- encoding: utf-8 -*-
"""
Copyright (c) 2019 - present AppSeed.us
"""

# Create your views here.
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from .forms import LoginForm, SignUpForm


def login_view(request):
    form = LoginForm(request.POST or None)

    msg = None

    if request.method == "POST":

        if form.is_valid():
            username = form.cleaned_data.get("username")
            password = form.cleaned_data.get("password")
            user = authenticate(username=username, password=password)
            if user is not None:
                login(request, user)
                return redirect("/")
            else:
                msg = '密码或账号有误'
        else:
            msg = '验证表单时出错'

    return render(request, "accounts/login.html", {"form": form, "msg": msg})


def register_user(request):
    # msg = None
    # success = False
    #
    # if request.method == "POST":
    #     form = SignUpForm(request.POST)
    #     if form.is_valid():
    #         form.save()
    #
    #         msg = '用户创建成功-请<a class="mb-0 text-info" href="/auth/login">登录</a>'
    #         success = True
    #
    #     else:
    #         msg = '注册格式无效'
    # else:
    #     form = SignUpForm()

    # return render(request, "accounts/register.html", {"form": form, "msg": msg, "success": success})
    return render(request, 'accounts/not_register.html')
