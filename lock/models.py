# -*- encoding: utf-8 -*-
"""
Copyright (c) 2019 - present AppSeed.us
"""
from django.db import models
from django.contrib.auth.models import User
from django.urls import reverse
from django.utils import timezone
from datetime import timedelta
from PIL import Image
from django.conf import settings

# Create your models here.

# 定义锁状态choices
LOCK_STATUS = [
    (0, '被使用'),
    (1, '未使用'),
]

# 定义活动类型choices
OPERATION_TYPE = [
    ('success', '创建'),
    ('waring', '更新'),
    ('danger', '删除'),
    ('info', '关闭')
]

# 定义性别choices
GENDER = [
    ('m', '男'),
    ('f', '女')
]

# 定义借用记录状态
BORROW_RECORD_STATUS = [
    (0, '使用中'),
    (1, '已归还')
]


# 位置模型
class Location(models.Model):
    name = models.CharField(max_length=50, blank=True)  # 位置名
    created_at = models.DateTimeField(default=timezone.now)  # 创建时间

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('category_list')

    class Meta:
        db_table = 'location'  # 定义表名


# 制造商模型
class Manufacturer(models.Model):
    name = models.CharField(max_length=50, blank=True)
    city = models.CharField(max_length=50, blank=True)
    contact = models.EmailField(max_length=50, blank=True)
    created_at = models.DateTimeField(default=timezone.now)
    updated_by = models.CharField(max_length=20, default='Admin')
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('manufacturer_list')

    class Meta:
        db_table = 'manufacturer'


# 电子锁模型
class Lock(models.Model):
    title = models.CharField('Title', max_length=20)
    description = models.TextField()
    created_at = models.DateTimeField('Created Time', default=timezone.now)
    updated_at = models.DateTimeField(auto_now=True)
    total_borrow_times = models.PositiveIntegerField(default=0)
    quantity = models.PositiveIntegerField(default=10)
    location = models.ForeignKey(  # 定义多对一外键
        Location,
        null=True,
        blank=True,
        on_delete=models.SET_NULL,  # 联级表删除时外键置空
        related_name='location'
    )

    manufacturer = models.ForeignKey(
        Manufacturer,
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='manufacturer'
    )

    status = models.IntegerField(choices=LOCK_STATUS, default=1)
    delete_status = models.IntegerField(default=0)  # 删除状态： 0.正常/1.删除
    lockshelf_number = models.CharField('Lockshelf Number', max_length=10, default='0001')
    updated_by = models.CharField(max_length=20, default='Admin')

    def get_absolute_url(self):
        return reverse('lock_list')

    def __str__(self):
        return self.title

    class Meta:
        db_table = 'lock'


# 用户日志模型
class UserActivity(models.Model):
    created_by = models.CharField(max_length=20, default='')
    created_at = models.DateTimeField(auto_now_add=True)
    operation_type = models.CharField(choices=OPERATION_TYPE, default='success', max_length=20)  # 选择活动类型
    target_model = models.CharField(max_length=20, default='')  # 操作的目标模型
    detail = models.CharField(max_length=50, default='')
    delete_status = models.IntegerField(default=0)  # 删除状态： 0.正常/1.删除

    def get_absolute_url(self):
        return reverse('user_activity_list')

    class Meta:
        db_table = 'user_activity'


# 用户资料模型
class Profile(models.Model):
    user = models.OneToOneField(User, null=True, on_delete=models.CASCADE)  # 一对一关系，级联User模型
    bio = models.TextField()  # 简介
    profile_pic = models.ImageField(upload_to='profile/%Y%m%d/', blank=True, null=True, default=settings.AVATAR_DEFAULT)    # 用户头像图片
    age = models.PositiveIntegerField(default=18)
    gender = models.CharField(max_length=10, choices=GENDER, default='m')
    phone_number = models.CharField(max_length=30, blank=True)
    email = models.EmailField(max_length=50, blank=True)

    def save(self, *args, **kwargs):
        # 调用原有的sava()功能
        profile = super(Profile, self).save(*args, **kwargs)

        # 按固定宽度缩放图片大小
        if self.profile_pic and not kwargs.get('update_fields'):
            image = Image.open(self.profile_pic)
            (x, y) = image.size  # 获取图片宽高（宽，高）
            new_x = 400
            new_y = int(new_x * (y / x))
            resized_image = image.resize((new_x, new_y), Image.ANTIALIAS)  # 裁剪图片
            resized_image.save(self.profile_pic.path)

        return profile

    def __str__(self):
        return str(self.user)

    def get_absolute_url(self):
        return reverse('home')

    class Meta:
        db_table = 'profile'


# 使用记录
class BorrowRecord(models.Model):
    borrower = models.CharField(max_length=20, blank=False)
    lock = models.CharField(max_length=20, blank=False)
    borrower_phone_number = models.CharField(max_length=30, blank=True)
    location = models.CharField(max_length=50, blank=False)
    manufacturer = models.CharField(max_length=50, blank=False)
    quantity = models.PositiveIntegerField(default=1)

    start_day = models.DateTimeField(default=timezone.now)
    end_day = models.DateTimeField(default=timezone.now() + timedelta(hours=1))

    open_or_close = models.IntegerField(choices=BORROW_RECORD_STATUS, default=0)
    delete_status = models.IntegerField(default=0)  # 删除状态： 0.正常/1.删除

    created_at = models.DateTimeField(default=timezone.now)
    created_by = models.CharField(max_length=20, blank=True)
    closed_at = models.DateTimeField(auto_now=True)
    closed_by = models.CharField(max_length=20, default='')

    def get_absolute_url(self):
        return reverse('record_list')

    def __str__(self):
        return self.borrower + '->' + self.lock

    class Meta:
        db_table = 'borrow_record'
