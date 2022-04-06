from django.http import HttpResponseRedirect
from django.urls import reverse_lazy
from django.views.generic import ListView, View
from django.db.models import Q
from lock.models import UserActivity
from django.core.paginator import Paginator
from django.contrib.auth.models import User
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import messages

# 分页每页显示条数
PAGINATOR_NUMBER = 5

# 跳转页数
delpage = 0


# 用户日志
class ActivityListView(LoginRequiredMixin, ListView):
    model = UserActivity
    context_object_name = 'activities'
    template_name = 'user_activity_list.html'
    count_total = 0
    search_value = ''
    created_by = ''
    order_field = '-created_at'
    all_users = User.objects.values()
    user_list = [x['username'] for x in all_users]

    def get_queryset(self):
        global delpage
        delpage = self.request.GET.get('page')

        search = self.request.GET.get('search')
        filter_user = self.request.GET.get('created_by')

        all_activities = UserActivity.objects.filter(delete_status=0)

        if filter_user:
            self.created_by = filter_user
            all_activities = all_activities.filter(Q(created_by=self.created_by) and Q(delete_status=0))

        if search:
            all_activities = all_activities.filter(Q(target_model__icontains=search) and Q(delete_status=0))
            self.search_value = search

        self.count_total = all_activities.count()
        paginator = Paginator(all_activities, PAGINATOR_NUMBER)
        page = self.request.GET.get('page')
        response = paginator.get_page(page)
        return response

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super(ActivityListView, self).get_context_data(**kwargs)
        context['count_total'] = self.count_total
        context['search'] = self.search_value
        context['user_list'] = self.user_list
        context['created_by'] = self.created_by
        context['orderby'] = self.order_field
        context['objects'] = self.get_queryset()
        return context


class ActivityDeleteView(LoginRequiredMixin, View):

    def get(self, request, *args, **kwargs):
        log_pk = kwargs["pk"]
        delete_log = UserActivity.objects.get(pk=log_pk)
        messages.error(request, f"已删除用户日志，ID: << {delete_log.id} >> ")
        delete_log.delete_status = 1
        delete_log.save()

        return HttpResponseRedirect(reverse_lazy('user_activity_list') + '?page=' + str(delpage))
