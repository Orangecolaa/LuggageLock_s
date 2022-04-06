from django.contrib.auth.models import User, Group
from django.views.generic import ListView, DetailView, CreateView, View
from django.contrib.auth.decorators import login_required, user_passes_test
from lock.groups_permissions import SuperUserRequiredMixin
from lock.groups_permissions import user_groups
from django.contrib.messages.views import messages
from django.shortcuts import redirect
from django.urls import reverse_lazy
from lock.forms import EmployeeCreateForm
from lock.models import UserActivity
from django.core.paginator import Paginator

# 分页每页显示条数
PAGINATOR_NUMBER = 5


# 员工列表
class EmployeeView(SuperUserRequiredMixin, ListView):
    model = User
    context_object_name = 'employees'
    template_name = 'employees/employees.html'
    search_value = ''
    order_field = 'date_joined'
    count_total = 0

    def get_queryset(self):
        all_users = User.objects.all()
        self.count_total = all_users.count()
        paginator = Paginator(all_users, PAGINATOR_NUMBER)
        page = self.request.GET.get('page')
        users = paginator.get_page(page)
        return users

    def get_context_data(self, *args, **kwargs):
        context = super(EmployeeView, self).get_context_data(*args, **kwargs)
        context['count_total'] = self.count_total
        context['search'] = self.search_value
        context['orderby'] = self.order_field
        context['objects'] = self.get_queryset()
        return context


# 添加员工
class EmployeeCreateView(SuperUserRequiredMixin, CreateView):
    model = User
    form_class = EmployeeCreateForm
    template_name = 'employees/employee_create.html'
    success_url = reverse_lazy('employees_list')

    def post(self, request, *args, **kwargs):
        super(EmployeeCreateView, self).post(request)
        new_user_name = request.POST['username']
        messages.success(request, f'新增用户 << {new_user_name} >>')
        UserActivity.objects.create(created_by=self.request.user.username,
                                    target_model='用户',
                                    detail=f'创建新用户 << {new_user_name} >>')
        return redirect('employees_list')


# 员工详情
class EmployeeDetailView(SuperUserRequiredMixin, DetailView):
    model = User
    context_object_name = 'employee'
    template_name = 'employees/employee_detail.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['groups'] = user_groups
        context['supers'] = 'is_superuser'
        return context


class EmployeeDeleteView(SuperUserRequiredMixin, View):

    def get(self, request, *args, **kwargs):
        user_pk = kwargs['pk']
        delete_user = User.objects.get(pk=user_pk)
        delete_user.delete()
        messages.error(request, f'已删除用户 << {delete_user.username} >> ')
        UserActivity.objects.create(created_by=self.request.user.username,
                                    operation_type='danger',
                                    target_model='用户',
                                    detail=f'删除用户 << {delete_user.username} >>')
        return redirect('employees_list')


# 用户组更新
@user_passes_test(lambda u: u.is_superuser)
@login_required(login_url='login')
def EmployeeUpdate(request, pk):
    current_user = User.objects.get(pk=pk)
    if request.method == 'POST':
        chosen_groups = [g for g in user_groups if "on" in request.POST.getlist(g)]
        current_user.groups.clear()  # 解除关联的组
        for each in chosen_groups:
            group = Group.objects.get(name=each)
            current_user.groups.add(group)  # 添加组
        if "on" in request.POST.getlist('is_superuser'):
            current_user.is_superuser = True    # 添加超级管理员权限
        else:
            current_user.is_superuser = False
        current_user.save()

        messages.success(request, f"已更新 << {current_user.username} >> 信息")
        return redirect('employees_detail', pk=pk)
