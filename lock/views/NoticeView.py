from django.views.generic import ListView, View
from lock.groups_permissions import SuperUserRequiredMixin
from django.shortcuts import redirect


# 通知列表
class NoticeListView(SuperUserRequiredMixin, ListView):
    context_object_name = 'notices'
    template_name = 'notice_list.html'

    # 未读通知的查询集
    def get_queryset(self):
        return self.request.user.notifications.unread()


# 通知更新状态
class NoticeUpdateView(SuperUserRequiredMixin, View):
    """Update Status of Notification"""

    # 处理 get 请求
    def get(self, request):
        # 获取未读消息
        notice_id = request.GET.get('notice_id')
        # 更新单条通知
        if notice_id:
            request.user.notifications.get(id=notice_id).mark_as_read()
            return redirect('notice_list')
        # 更新全部通知
        else:
            request.user.notifications.mark_all_as_read()
            return redirect('notice_list')