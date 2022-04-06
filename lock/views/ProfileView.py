import logging
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from django.views.generic import DetailView
from django.views.generic.edit import CreateView, UpdateView

from lock.models import Profile
from lock.forms import ProfileForm
from django.contrib.auth.mixins import LoginRequiredMixin


# 系统日志设置
logger = logging.getLogger(__name__)
# 分页每页显示条数
PAGINATOR_NUMBER = 5


# 用户资料详情
class ProfileDetailView(LoginRequiredMixin, DetailView):
    model = Profile
    context_object_name = 'profile'
    template_name = 'profile/profile_detail.html'

    def get_context_data(self, *args, **kwargs):
        current_user = get_object_or_404(Profile, pk=self.kwargs['pk'])
        context = super(ProfileDetailView, self).get_context_data(**kwargs)
        context['current_user'] = current_user
        return context


# 用户资料创建
class ProfileCreateView(LoginRequiredMixin, CreateView):
    model = Profile
    template_name = 'profile/profile_create.html'

    form_class = ProfileForm

    def form_valid(self, form) -> HttpResponse:
        form.instance.user = self.request.user
        return super().form_valid(form)


# 用户资料更新
class ProfileUpdateView(LoginRequiredMixin, UpdateView):
    model = Profile

    form_class = ProfileForm
    template_name = 'profile/profile_update.html'
