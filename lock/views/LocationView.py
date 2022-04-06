import logging

from django.http import HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.views.generic import ListView, View
from django.views.generic.edit import CreateView
from django.db.models import Q
from lock.models import Location, UserActivity

from lock.forms import LocationCreateEditForm
from lock.notification import send_notification

from django.core.paginator import Paginator

from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import messages


# 系统日志设置
logger = logging.getLogger(__name__)
# 分页每页显示条数
PAGINATOR_NUMBER = 5


# 位置列表
class LocationListView(LoginRequiredMixin, ListView):
    model = Location
    context_object_name = 'locations'
    template_name = 'location/location_list.html'
    count_total = 0
    search_value = ''
    order_field = '-created_at'

    def get_queryset(self):
        search = self.request.GET.get('search')
        order_by = self.request.GET.get('orderby')
        if order_by:
            all_locations = Location.objects.all().order_by(order_by)
            self.order_field = order_by
        else:
            all_locations = Location.objects.all().order_by(self.order_field)
        if search:
            all_locations = Location.objects.filter(Q(name__icontains=search))
            self.search_value = search

        self.count_total = all_locations.count()
        paginator = Paginator(all_locations, PAGINATOR_NUMBER)
        page = self.request.GET.get('page')
        Locations = paginator.get_page(page)
        return Locations

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super(LocationListView, self).get_context_data(**kwargs)
        context['count_total'] = self.count_total
        context['search'] = self.search_value
        context['orderby'] = self.order_field
        context['objects'] = self.get_queryset()
        return context


# 位置添加
class LocationCreateView(LoginRequiredMixin, CreateView):
    model = Location

    form_class = LocationCreateEditForm
    template_name = 'location/location_create.html'
    success_url = reverse_lazy('location_list')

    def form_valid(self, form):
        new_location = form.save(commit=False)
        new_location.save()
        messages.success(self.request, f'新增位置 << {new_location} >>')
        send_notification(self.request.user, new_location, verb=f'添加新位置 << {new_location.name} >>')
        logger.info(f'{self.request.user} created Location {new_location.name}')
        UserActivity.objects.create(created_by=self.request.user.username,
                                    target_model='位置',
                                    detail=f'创建位置 << {new_location.name} >>')
        return super(LocationCreateView, self).form_valid(form)


# 位置删除
class LocationDeleteView(LoginRequiredMixin, View):
    def get(self, request, *args, **kwargs):
        location_pk = kwargs['pk']
        delete_location = Location.objects.get(pk=location_pk)
        delete_location.delete()
        messages.error(request, f'已删除位置 << {delete_location.name} >>')
        send_notification(self.request.user, delete_location, verb=f'删除位置 << {delete_location.name} >>')
        UserActivity.objects.create(created_by=self.request.user.username,
                                    operation_type='danger',
                                    target_model='位置',
                                    detail=f'删除位置 << {delete_location.name} >>')
        logger.info(f'{self.request.user} delete Location {delete_location.name}')
        return HttpResponseRedirect(reverse('location_list'))
