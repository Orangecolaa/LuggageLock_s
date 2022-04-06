# -*- encoding: utf-8 -*-
"""
Copyright (c) 2019 - present AppSeed.us
"""

from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User


class LoginForm(forms.Form):
    username = forms.CharField(
        widget=forms.TextInput(
            attrs={
                "placeholder": "用户名",
                "class": "form-control"
            }
        ))
    password = forms.CharField(
        widget=forms.PasswordInput(
            attrs={
                "placeholder": "密码",
                "class": "form-control"
            }
        ))


class SignUpForm(UserCreationForm):
    username = forms.CharField(
        label="用户名",
        widget=forms.TextInput(
            attrs={
                "placeholder": "用户名",
                "class": "form-control"
            }
        ))
    email = forms.EmailField(
        label="邮箱",
        widget=forms.EmailInput(
            attrs={
                "placeholder": "邮箱",
                "class": "form-control"
            }
        ))
    password1 = forms.CharField(
        label='密码',
        widget=forms.PasswordInput(
            attrs={
                "placeholder": "密码",
                "class": "form-control",
            }
        ))
    password2 = forms.CharField(
        label='重复密码',
        widget=forms.PasswordInput(
            attrs={
                "placeholder": "重复密码",
                "class": "form-control"
            }
        ))

    class Meta:
        model = User
        fields = ('username', 'email', 'password1', 'password2')
