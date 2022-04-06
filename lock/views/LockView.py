import logging

from django.http import HttpResponseRedirect
from django.urls import reverse
from django.shortcuts import redirect
from django.views.generic import ListView, DetailView, View
from django.views.generic.edit import CreateView, UpdateView
from django.db.models import Q
from lock.models import Lock, UserActivity, BorrowRecord
from comment.models import Comment
from comment.forms import CommentForm
from lock.forms import LockCreateEditForm
from django.core.paginator import Paginator
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import messages


# 系统日志设置
logger = logging.getLogger(__name__)
# 分页每页显示条数
PAGINATOR_NUMBER = 5


# 行李锁列表
class LockListView(LoginRequiredMixin, ListView):
    model = Lock
    context_object_name = 'locks'
    template_name = 'lock/lock_list.html'
    search_value = ''
    order_field = 'updated_at'
    count_total = 0

    def get_queryset(self):
        search = self.request.GET.get('search')
        order_by = self.request.GET.get('orderby')

        if order_by:
            all_locks = Lock.objects.filter(delete_status=0).order_by(order_by)
            self.order_field = order_by
        else:
            all_locks = Lock.objects.filter(delete_status=0).order_by(self.order_field)

        if search:
            all_locks = all_locks.filter(Q(title__icontains=search) | Q(manufacturer__name__icontains=search) |
                                         Q(location__name__icontains=search and Q(delete_status=0)))
            self.search_value = search
        self.count_total = all_locks.count()
        paginator = Paginator(all_locks, PAGINATOR_NUMBER)  # 分页
        page = self.request.GET.get('page')
        locks = paginator.get_page(page)
        return locks

    def get_context_data(self, *args, **kwargs):
        context = super(LockListView, self).get_context_data(*args, **kwargs)
        context['count_total'] = self.count_total
        context['search'] = self.search_value
        context['orderby'] = self.order_field
        context['objects'] = self.get_queryset()
        return context


# 行李锁详情
class LockDetailView(LoginRequiredMixin, DetailView):
    model = Lock
    context_object_name = 'lock'
    template_name = 'lock/lock_detail.html'
    comment_form = CommentForm()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        current_lock_name = self.get_object().title
        logger.info(f'Lock <<{current_lock_name}>> retrieved from db')
        comments = Comment.objects.filter(lock=self.get_object().id)
        related_records = BorrowRecord.objects.filter(lock=current_lock_name)
        context['related_records'] = related_records
        context['comments'] = comments
        context['cpmment_form'] = self.comment_form
        return context


# 行李锁创建
class LockCreateView(LoginRequiredMixin, CreateView):
    model = Lock
    form_class = LockCreateEditForm
    template_name = 'lock/lock_create.html'

    def post(self, request, *args, **kwargs):
        super(LockCreateView, self).post(request)
        new_lock_name = request.POST['title']
        messages.success(request, f'新增行李锁 << {new_lock_name} >>')
        UserActivity.objects.create(created_by=self.request.user.username,
                                    target_model='行李锁',
                                    detail=f'创建行李锁 << {new_lock_name} >>')
        return redirect('lock_list')


# 行李锁更新
class LockUpdateView(LoginRequiredMixin, UpdateView):
    model = Lock
    form_class = LockCreateEditForm
    template_name = 'lock/lock_update.html'

    def post(self, request, *args, **kwargs):
        current_lock = self.get_object()
        current_lock.updated_by = self.request.user.username
        current_lock.save(update_fields=['updated_by'])
        UserActivity.objects.create(created_by=self.request.user.username,
                                    operation_type='warning',
                                    target_model='行李锁',
                                    detail=f'更新行李锁 << {current_lock.title} >>')
        return super(LockUpdateView, self).post(request, *args, **kwargs)

    def form_valid(self, form):
        title = form.cleaned_data['title']
        messages.warning(self.request, f'更新行李锁 << {title} >> 成功')
        return super().form_valid(form)


# 行李锁删除
class LockDeleteView(LoginRequiredMixin, View):

    def get(self, request, *args, **kwargs):
        lock_pk = kwargs['pk']
        delete_lock = Lock.objects.get(pk=lock_pk)
        delete_lock.delete_status = 1
        delete_lock.save()
        messages.error(request, f'已删除行李锁 << {delete_lock.title} >> ')
        UserActivity.objects.create(created_by=self.request.user.username,
                                    operation_type='danger',
                                    target_model='行李锁',
                                    detail=f'删除行李锁 << {delete_lock.title} >>')
        return HttpResponseRedirect(reverse('lock_list'))
