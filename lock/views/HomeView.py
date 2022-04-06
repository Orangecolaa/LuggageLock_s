from django.http import HttpResponseRedirect
from django.db.models.functions import TruncDay
from django.shortcuts import render
from django.views.generic import TemplateView

from django.db.models import Q, Sum, Count
from lock.models import Lock, Location, Manufacturer, UserActivity, Profile, BorrowRecord
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from datetime import datetime, timedelta


# 主页
class HomeView(LoginRequiredMixin, TemplateView):
    template_name = 'index.html'
    context = {}

    def get(self, request, *args, **kwargs):
        # 行李锁总数
        lock_count = Lock.objects.filter(delete_status=0).aggregate(Sum('quantity'))['quantity__sum']
        # 行李锁，位置，制造商总数
        date_count = {
            'lock': lock_count,
            'location': Location.objects.all().count(),
            'manufacturer': Manufacturer.objects.all().count()
        }
        # 用户活动
        user_activities = UserActivity.objects.filter(delete_status=0).order_by('-created_at')[:5]
        # 用户头像
        user_avatar = {e.created_by: Profile.objects.get(user__username=e.created_by).profile_pic.url for e in user_activities}
        # 行李锁近期库存
        short_inventory = Lock.objects.filter(delete_status=0).order_by('quantity')[:5]
        # 所有用户
        new_users = Profile.objects.order_by('-user__date_joined')[:5]
        all_users = User.objects.all().count()
        # 今日归还
        today = datetime.now().day
        locks_return_today = BorrowRecord.objects.filter(end_day__day=today)
        number_locks_return_today = locks_return_today.count()
        # 本周使用
        now_time = datetime.now()
        day_num = now_time.isoweekday()
        week_day = (now_time - timedelta(days=day_num))
        lent_locks_this_week = BorrowRecord.objects.filter(created_at__range=(week_day, now_time)).count()
        # 最近使用记录
        new_closed_records = BorrowRecord.objects.filter(open_or_close=1).order_by('-closed_at')[:5]

        self.context = {'data_count': date_count, 'recent_user_activities': user_activities, 'user_avatar': user_avatar,
                        'new_users': new_users, 'all_users': all_users,
                        'short_inventory': short_inventory, 'lent_locks_this_week': lent_locks_this_week,
                        'locks_return_today': locks_return_today,
                        'number_locks_return_today': number_locks_return_today,
                        'new_closed_records': new_closed_records,
                        'segment': 'index'}

        return render(request, self.template_name, self.context)


# 全局搜索
@login_required(login_url="/login/")
def global_search(request):
    search_value = request.POST.get('global_search')  # 获取搜索条件
    if search_value == '':
        return HttpResponseRedirect('/')
    # 模糊查询icontains
    r_location = Location.objects.filter(Q(name__icontains=search_value))
    r_manufacturer = Manufacturer.objects.filter(Q(name__icontains=search_value) | Q(contact__icontains=search_value))
    r_lock = Lock.objects.filter(Q(title__icontains=search_value))
    r_borrow = BorrowRecord.objects.filter(Q(borrower__icontains=search_value) | Q(lock__icontains=search_value))

    context = {
        'locations': r_location,
        'manufacturers': r_manufacturer,
        'locks': r_lock,
        'records': r_borrow,
    }

    return render(request, 'global_search.html', context=context)


# 图表功能
class ChartView(LoginRequiredMixin, TemplateView):
    template_name = 'charts.html'
    context = {}

    def get(self, request, *args, **kwargs):
        # 锁库存top5数据
        top_5_lock = Lock.objects.order_by('-quantity')[:5].values_list('title', 'quantity')
        top_5_lock_titles = [l[0] for l in top_5_lock]
        top_5_lock_quantities = [l[1] for l in top_5_lock]
        # 被使用锁最多数据
        top_borrow = Lock.objects.order_by('-total_borrow_times')[:5].values_list('title', 'total_borrow_times')
        top_borrow_titles = [b[0] for b in top_borrow]
        top_borrow_times = [b[1] for b in top_borrow]
        # 使用记录状态
        r_open = BorrowRecord.objects.filter(open_or_close=0).count()
        r_close = BorrowRecord.objects.filter(open_or_close=1).count()
        # 本周每日使用记录
        b = BorrowRecord.objects.annotate(day=TruncDay('created_at')).values('day').annotate(c=Count('id'))
        c = b[::-1][:7]    # 取今天往前7天
        print(c)
        week_borrow = [e['day'].strftime('%m/%d') for e in c[::-1]]
        print(week_borrow)
        count_week_borrow = [e['c'] for e in c[::-1]]

        self.context = {'top_5_lock_titles': top_5_lock_titles, 'top_5_lock_quantities': top_5_lock_quantities,
                        'top_borrow_titles': top_borrow_titles, 'top_borrow_times': top_borrow_times,
                        'r_open': r_open, 'r_close': r_close,
                        'week_borrow': week_borrow, 'count_week_borrow': count_week_borrow,
                        }

        return render(request, self.template_name, self.context)
