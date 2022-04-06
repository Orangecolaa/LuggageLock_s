from django import forms
from django.contrib.auth.models import User
from .models import Lock, Location, Manufacturer, Profile, BorrowRecord
from flatpickr import DateTimePickerInput
from django.contrib.auth.forms import UserCreationForm


# 行李锁创建表单
class LockCreateEditForm(forms.ModelForm):

    class Meta:
        model = Lock
        fields = (
            'title',
            'description',
            'quantity',
            'location',
            'manufacturer',
            'lockshelf_number',
        )
        labels = {
            'title': '名称',
            'description': '描述',
            'quantity': '数量',
            'location': '位置',
            'manufacturer': '制造商',
            'lockshelf_number': '锁架',
        }


# 位置创建表单
class LocationCreateEditForm(forms.ModelForm):
    class Meta:
        model = Location
        fields = (
            'name',
        )
        labels = {
            'name': '名称',
        }


# 制造商创建表单
class ManuCreateEditForm(forms.ModelForm):
    class Meta:
        model = Manufacturer
        fields = (
            'name',
            'city',
            'contact',
        )
        labels = {
            'name': '名称',
            'city': '城市',
            'contact': '联系邮箱',
        }


# 用户资料创建表单
class ProfileForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = (
            'profile_pic',
            'bio',
            'age',
            'gender',
            'phone_number',
            'email',
        )
        labels = {
            'profile_pic': '头像图片',
            'bio': '个人简介',
            'age': '年龄',
            'gender': '性别',
            'phone_number': '手机号',
            'email': '邮箱',
        }


# 使用记录创建表单
class BorrowRecordCreateForm(forms.ModelForm):
    class Meta:
        model = BorrowRecord
        fields = (
            'borrower',
            'borrower_phone_number',
            'lock',
            'manufacturer',
            'location',
            'quantity',
            'start_day',
            'end_day',
        )
        labels = {
            'borrower': '使用者',
            'borrower_phone_number': '手机号',
            'lock': '行李锁名称',
            'manufacturer': '制造商',
            'location': '位置',
            'quantity': '数量',
            'start_day': '开始时间',
            'end_day': '归还时间',
        }
        widgets = {
            'start_day': DateTimePickerInput(options={'dateFormat': 'Y-m-d H:i', }),    # 使用日期选择板
            'end_day': DateTimePickerInput(options={'dateFormat': 'Y-m-d H:i', }),
        }


# 用户创建表单
class EmployeeCreateForm(UserCreationForm):
    class Meta:
        model = User
        fields = ('username', 'email', 'password1', 'password2')
        labels = {
            'username': '用户名',
            'email': '邮箱',
            'password1': '密码',
            'password2': '重复密码'
        }
