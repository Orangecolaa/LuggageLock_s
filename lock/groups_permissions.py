from django.core.exceptions import PermissionDenied
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin


# 指定可访问用户组
user_groups = ['api', 'download_data']


# 判断是否超级管理员
def check_superuser(user):
    if not user.is_superuser:
        raise PermissionDenied("您没有访问此页面的权限！")


# 判断管理员是否在所在组
def check_user_group(user, group_name):
    user_group = user.groups.all().values_list('name', flat=True)
    if group_name not in user_group:
        raise PermissionDenied("您没有访问此页面的权限！")


# 允许访问数据中心的组
def allowed_groups(group_name=None):

    def decorator(view_func):
        def wrapper_func(request, *args, **kwargs):

            group = None
            if request.user.groups.exists():
                group = request.user.groups.filter(name='download_data')
            if group[0].name in group_name:
                return view_func(request, *args, **kwargs)
            else:
                raise PermissionDenied("您没有访问此页面的权限！")

        return wrapper_func

    return decorator


class SuperUserRequiredMixin(LoginRequiredMixin, UserPassesTestMixin):

    def test_func(self):
        return self.request.user.is_superuser
