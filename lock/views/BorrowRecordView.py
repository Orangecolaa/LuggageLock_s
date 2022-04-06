import json

from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from django.views.generic import ListView, DetailView, View
from django.views.generic.edit import CreateView
from django.db.models import Q
from lock.models import Lock, UserActivity, BorrowRecord
from lock.forms import BorrowRecordCreateForm

from django.core.paginator import Paginator
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import messages

# 分页每页显示条数
PAGINATOR_NUMBER = 5


# 使用记录创建
class BorrowRecordCreateView(LoginRequiredMixin, CreateView):
    model = BorrowRecord
    template_name = 'borrow_records/create.html'
    form_class = BorrowRecordCreateForm

    def get_form(self, **kwargs):
        form = super().get_form()
        return form

    def form_valid(self, form):
        selected_lock = Lock.objects.get(title=form.cleaned_data['lock'])
        form.instance.created_by = self.request.user.username
        form.instance.start_day = form.cleaned_data['start_day']
        form.instance.end_day = form.cleaned_data['end_day']
        form.save()

        # 更改行李锁模型上的字段
        selected_lock.status = 0
        selected_lock.total_borrow_times += 1
        selected_lock.quantity -= int(form.cleaned_data['quantity'])
        selected_lock.save()

        # 创建日志
        borrower_name = form.cleaned_data['borrower']
        lock_name = selected_lock.title

        messages.success(self.request, f" << {borrower_name} >> 使用了行李锁 << {lock_name} >>")
        UserActivity.objects.create(created_by=self.request.user.username,
                                    target_model='使用记录',
                                    detail=f"<< {borrower_name} >> 使用了行李锁 << {lock_name} >>")

        return super(BorrowRecordCreateView, self).form_valid(form)


@login_required(login_url='login')
def auto_lock(request):
    if request.is_ajax():
        query = request.GET.get("term", "")
        lock_names = Lock.objects.filter(title__icontains=query)
        results = [b.title for b in lock_names]
        data = json.dumps(results)
    mimetype = "application/json"
    return HttpResponse(data, mimetype)


# 使用记录详情
class BorrowRecordDetailView(LoginRequiredMixin, DetailView):
    model = BorrowRecord
    context_object_name = 'record'
    template_name = 'borrow_records/detail.html'


# 使用记录列表
class BorrowRecordListView(LoginRequiredMixin, ListView):
    model = BorrowRecord
    template_name = 'borrow_records/list.html'

    context_object_name = 'records'
    count_total = 0
    search_value = ''
    order_field = "-closed_at"

    def get_queryset(self):
        search = self.request.GET.get("search")
        order_by = self.request.GET.get("orderby")
        if order_by:
            all_records = BorrowRecord.objects.filter(delete_status=0).order_by(order_by)
            self.order_field = order_by
        else:
            all_records = BorrowRecord.objects.filter(delete_status=0).order_by(self.order_field)
        if search:
            all_records = BorrowRecord.objects.filter(
                Q(borrower__icontains=search) | Q(lock__icontains=search) | Q(
                    borrower_phone_number__icontains=search) and Q(delete_status=0))
            self.search_value = search
        self.count_total = all_records.count()
        paginator = Paginator(all_records, PAGINATOR_NUMBER)
        page = self.request.GET.get('page')
        records = paginator.get_page(page)
        return records

    def get_context_data(self, *args, **kwargs):
        context = super(BorrowRecordListView, self).get_context_data(*args, **kwargs)
        context['count_total'] = self.count_total
        context['search'] = self.search_value
        context['orderby'] = self.order_field
        context['objects'] = self.get_queryset()
        return context


# 使用记录删除
class BorrowRecordDeleteView(LoginRequiredMixin, View):

    def get(self, request, *args, **kwargs):
        record_pk = kwargs["pk"]
        delete_record = BorrowRecord.objects.get(pk=record_pk)
        model_name = delete_record.__class__.__name__
        messages.error(request, f"已删除 << {delete_record.borrower} >> 使用 << {delete_record.lock} >> 的记录")
        delete_record.delete_status = 1
        delete_record.save()
        UserActivity.objects.create(created_by=self.request.user.username,
                                    operation_type="danger",
                                    target_model='使用记录',
                                    detail=f"删除 << {delete_record.borrower} >> 的使用记录")
        return HttpResponseRedirect(reverse("record_list"))


# 使用记录关闭
class BorrowRecordClose(LoginRequiredMixin, View):
    def get(self, request, *args, **kwargs):
        close_record = BorrowRecord.objects.get(pk=self.kwargs['pk'])
        close_record.closed_by = self.request.user.username
        close_record.open_or_close = 1
        close_record.save()

        borrowed_lock = Lock.objects.get(title=close_record.lock)
        borrowed_lock.quantity += close_record.quantity
        count_record_same_lock = BorrowRecord.objects.filter(lock=close_record.lock).count()
        if count_record_same_lock >= 1:
            borrowed_lock.status = 1

        borrowed_lock.save()

        UserActivity.objects.create(created_by=self.request.user.username,
                                    operation_type="info",
                                    target_model='使用记录',
                                    detail=f"关闭 << {close_record.borrower} >> 使用 << {close_record.lock} >> 的记录")
        return HttpResponseRedirect(reverse("record_list"))
