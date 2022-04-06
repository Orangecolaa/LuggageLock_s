# -*- encoding: utf-8 -*-
'''
Copyright (c) 2019 - present AppSeed.us
'''

from django.urls import path
from lock.views.HomeView import HomeView, ChartView, global_search
from lock.views.LockView import LockListView, LockCreateView, LockDetailView, LockUpdateView, LockDeleteView
from lock.views.LocationView import LocationListView, LocationCreateView, LocationDeleteView
from lock.views.ManufacturerView import ManufacturerListView, ManufacturerCreateView, ManufacturerDeleteView, ManufacturerUpdateView
from lock.views.ActivityView import ActivityListView, ActivityDeleteView
from lock.views.BorrowRecordView import BorrowRecordListView, BorrowRecordCreateView, BorrowRecordDetailView, BorrowRecordDeleteView, BorrowRecordClose, auto_lock
from lock.views.ProfileView import ProfileCreateView, ProfileUpdateView, ProfileDetailView
from lock.views.DataCenterView import DataCenterView, download_data
from lock.views.EmployeesView import EmployeeView, EmployeeCreateView, EmployeeUpdate, EmployeeDetailView, EmployeeDeleteView
from lock.views.NoticeView import NoticeListView, NoticeUpdateView

urlpatterns = [
    # 主页url
    path('', HomeView.as_view(), name='home'),
    # 行李锁url
    path('lock/list', LockListView.as_view(), name='lock_list'),
    path('lock/create', LockCreateView.as_view(), name='lock_create'),
    path('lock/update/<int:pk>/', LockUpdateView.as_view(), name='lock_update'),
    path('lock/delete/<int:pk>/', LockDeleteView.as_view(), name='lock_delete'),
    path('lock/detail/<int:pk>/', LockDetailView.as_view(), name='lock_detail'),

    # 位置url
    path('location/list', LocationListView.as_view(), name='location_list'),
    path('location/create', LocationCreateView.as_view(), name='location_create'),
    path('location/delete/<int:pk>/', LocationDeleteView.as_view(), name='location_delete'),

    # 制造商url
    path('manufacturer/list', ManufacturerListView.as_view(), name='manufacturer_list'),
    path('manufacturer/create', ManufacturerCreateView.as_view(), name='manufacturer_create'),
    path('manufacturer/delete/<int:pk>/', ManufacturerDeleteView.as_view(), name='manufacturer_delete'),
    path('manufacturer/update/<int:pk>/', ManufacturerUpdateView.as_view(), name='manufacturer_update'),

    # 用户日志url
    path('user/activity/list', ActivityListView.as_view(), name='user_activity_list'),
    path('user/activity/list/<int:pk>/', ActivityDeleteView.as_view(), name='user_activity_delete'),

    # 用户资料url
    path('user/profile-create/', ProfileCreateView.as_view(), name='profile_create'),
    path('user/<int:pk>/profile/', ProfileDetailView.as_view(), name='profile_detail'),
    path('user/<int:pk>/profile-update/', ProfileUpdateView.as_view(), name='profile_update'),

    # 使用记录url
    path('record-create/', BorrowRecordCreateView.as_view(), name='record_create'),
    path('record-create/autocomplete-lock-name/', auto_lock, name='auto_lock_name'),
    path('record-list/', BorrowRecordListView.as_view(), name='record_list'),
    path('record-detail/<int:pk>/', BorrowRecordDetailView.as_view(), name='record_detail'),
    path('record-delete/<int:pk>/', BorrowRecordDeleteView.as_view(), name='record_delete'),
    path('record-close/<int:pk>/', BorrowRecordClose.as_view(), name='record_close'),

    # 数据中心url
    path('data-center/', DataCenterView.as_view(), name='data_center'),
    path('data-download/<str:model_name>/', download_data, name='data_download'),

    # 图表url
    path('charts/', ChartView.as_view(), name='chart'),

    # 全局搜索url
    path('global-search/', global_search, name='global_search'),

    # 员工url
    path('employees/', EmployeeView.as_view(), name='employees_list'),
    path('employess-create/', EmployeeCreateView.as_view(), name='employees_create'),
    path('employees-detail/<int:pk>', EmployeeDetailView.as_view(), name='employees_detail'),
    path('employees-update/<int:pk>', EmployeeUpdate, name='employee_update'),
    path('employess-delete/<int:pk>', EmployeeDeleteView.as_view(), name='employees_delete'),

    # 通知url
    path('notice-list/', NoticeListView.as_view(), name='notice_list'),
    path('notice-update/', NoticeUpdateView.as_view(), name='notice_update'),
]
