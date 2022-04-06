import logging

from django.http import HttpResponseRedirect
from django.urls import reverse, reverse_lazy

from django.views.generic import ListView, View
from django.views.generic.edit import CreateView, UpdateView
from django.db.models import Q
from lock.models import Manufacturer, UserActivity

from lock.forms import ManuCreateEditForm
from lock.notification import send_notification

from django.core.paginator import Paginator


from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import messages


# 系统日志设置
logger = logging.getLogger(__name__)
# 分页每页显示条数
PAGINATOR_NUMBER = 5


# 制造商列表
class ManufacturerListView(LoginRequiredMixin, ListView):
    model = Manufacturer
    context_object_name = 'manufacturers'
    template_name = 'manufacturer/manufacturer_list.html'
    count_total = 0
    search_value = ''
    order_field = '-created_at'

    def get_queryset(self):
        search = self.request.GET.get('search')
        order_by = self.request.GET.get('orderby')
        if order_by:
            all_manufacturers = Manufacturer.objects.all().order_by(order_by)
            self.order_field = order_by
        else:
            all_manufacturers = Manufacturer.objects.all().order_by(self.order_field)
        if search:
            all_manufacturers = Manufacturer.objects.filter(
                Q(name__icontains=search) | Q(city__icontains=search) | Q(contact__icontains=search))
            self.search_value = search
        self.count_total = all_manufacturers.count()
        paginator = Paginator(all_manufacturers, PAGINATOR_NUMBER)
        page = self.request.GET.get('page')
        manufacturers = paginator.get_page(page)
        return manufacturers

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super(ManufacturerListView, self).get_context_data(**kwargs)
        context['count_total'] = self.count_total
        context['search'] = self.search_value
        context['orderby'] = self.order_field
        context['objects'] = self.get_queryset()
        return context


# 制造商创建
class ManufacturerCreateView(LoginRequiredMixin, CreateView):
    model = Manufacturer

    form_class = ManuCreateEditForm
    template_name = 'manufacturer/manufacturer_create.html'
    success_url = reverse_lazy('manufacturer_list')

    def form_valid(self, form):
        new_manu = form.save(commit=False)
        new_manu.save()
        messages.success(self.request, f"新增制造商 << {new_manu.name} >>")
        send_notification(self.request.user, new_manu, verb=f'添加新制造商 << {new_manu.name} >>')
        logger.info(f'{self.request.user} created Manufacturer {new_manu.name}')

        UserActivity.objects.create(created_by=self.request.user.username,
                                    target_model='制造商',
                                    detail=f"创建制造商 << {new_manu.name} >>")
        return super(ManufacturerCreateView, self).form_valid(form)


# 制造商更新
class ManufacturerUpdateView(LoginRequiredMixin, UpdateView):
    model = Manufacturer

    form_class = ManuCreateEditForm
    template_name = 'manufacturer/manufacturer_update.html'

    def post(self, request, *args, **kwargs):
        current_manu = self.get_object()
        current_manu.updated_by = self.request.user.username
        current_manu.save(update_fields=['updated_by'])
        UserActivity.objects.create(created_by=self.request.user.username,
                                    operation_type="warning",
                                    target_model='制造商',
                                    detail=f"更新制造商 << {current_manu.name} >>")
        return super(ManufacturerUpdateView, self).post(request, *args, **kwargs)

    def form_valid(self, form):
        title = form.cleaned_data['name']
        messages.warning(self.request, f"更新制造商 << {title} >> 成功")
        return super().form_valid(form)


# 制造商删除
class ManufacturerDeleteView(LoginRequiredMixin, View):

    def get(self, request, *args, **kwargs):
        manu_pk = kwargs['pk']
        delete_manu = Manufacturer.objects.get(pk=manu_pk)
        messages.error(request, f"已删除制造商 << {delete_manu.name} >>")
        delete_manu.delete()
        send_notification(self.request.user, delete_manu, verb=f'删除制造商 << {delete_manu.name} >>')
        logger.info(f'{self.request.user} delete Manufacturer {delete_manu.name}')
        UserActivity.objects.create(created_by=self.request.user.username,
                                    operation_type="danger",
                                    target_model='制造商',
                                    detail=f"删除制造商 << {delete_manu.name} >>")
        return HttpResponseRedirect(reverse("manufacturer_list"))
