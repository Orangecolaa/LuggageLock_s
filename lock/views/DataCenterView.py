import pandas as pd
from django.http import HttpResponse
from django.shortcuts import render
from django.views.generic import TemplateView
from lock.groups_permissions import allowed_groups
from django.apps import apps
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.contrib.auth.mixins import LoginRequiredMixin
from util.useful import get_n_days_ago
from lock.groups_permissions import check_user_group

# 文件日期
TODAY = get_n_days_ago(0, "%Y%m%d")
# 模型列表
allowed_models = ['Lock', 'Location', 'Manufacturer', 'Profile', 'UserActivity', 'BorrowRecord']


# 数据中心视图
@method_decorator(allowed_groups(group_name=['download_data']), name='dispatch')
class DataCenterView(LoginRequiredMixin, TemplateView):
    template_name = 'download_data.html'

    def get(self, request, *args, **kwargs):
        data = {m.objects.model._meta.db_table:
                    {"source": pd.DataFrame(list(m.objects.all().values())),
                     "path": f"{str(settings.BASE_DIR)}/datacenter/{m.__name__}_{TODAY}.csv",
                     "file_name": f"{m.__name__}_{TODAY}.csv"} for m in apps.get_models() if
                m.__name__ in allowed_models}
        count_total = {k: v['source'].shape[0] for k, v in data.items()}
        return render(request, self.template_name, context={'model_list': count_total})


# 数据下载
@login_required(login_url='login')
@allowed_groups(group_name=['download_data'])
def download_data(request, model_name):
    check_user_group(request.user, "download_data")  # 判断超级管理员是否在所在组

    download = {m.objects.model._meta.db_table:
                    {"source": pd.DataFrame(list(m.objects.all().values())),
                     "path": f"{str(settings.BASE_DIR)}/datacenter/{m.__name__}_{TODAY}.csv",
                     "file_name": f"{m.__name__}_{TODAY}.csv"} for m in apps.get_models() if
                m.__name__ in allowed_models}

    download[model_name]['source'].to_csv(download[model_name]['path'], index=False, encoding='utf_8_sig')
    # download_file = pd.read_csv(download[model_name]['path'], encoding='utf-8')
    # response = HttpResponse(download_file, content_type="text/csv")
    response = HttpResponse(open(download[model_name]['path'], 'r', encoding='utf-8'), content_type="text/csv")
    response['Content-Disposition'] = f"attachment;filename={download[model_name]['file_name']}"
    return response
