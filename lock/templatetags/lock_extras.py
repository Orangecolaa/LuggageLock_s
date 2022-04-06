from django import template
from django.utils import timezone
import math
import requests

# 引入template.Library便于自定义过滤器
register = template.Library()


# 页码
@register.inclusion_tag('inclusions/_pagination.html', takes_context=True)
def show_pagination(context):
    return {
        'page_objects': context['objects'],
        'search': context['search'],
        'orderby': context['orderby'], }


# 信息
@register.inclusion_tag('inclusions/_messages.html', takes_context=True)
def show_messages(context):
    return {'messages': context['messages'], }


@register.simple_tag(takes_context=True)
def param_replace(context, **kwargs):
    """
    Based on
    https://stackoverflow.com/questions/22734695/next-and-before-links-for-a-django-paginated-query/22735278#22735278
    """
    d = context['request'].GET.copy()
    for k, v in kwargs.items():
        d[k] = v
    for k in [k for k, v in d.items() if not v]:
        del d[k]
    return d.urlencode()


# 天气
@register.inclusion_tag('inclusions/_weather.html', takes_context=True)
def show_weather(context):

    # 知心天气API
    # params = {
    #     'key': 'Sw1663GOXxPKA4mCD',
    #     'location': 'guangzhou',
    #     'language': 'zh-Hans',
    #     'unit': 'c'
    # }
    # url = 'https://api.seniverse.com/v3/weather/now.json'
    # data = requests.get(url).json()['results']
    # weather = {
    #         'city': data[0]['location']['name'],
    #         'temperature': float("{0:.2}".format(data[0]['now']['temperature'])),
    #         'description': data[0]['now']['text'],
    # }

    # 和风天气API
    params = {
        'key': '9a5c99b04fbb480ca27a14b333e05953',
        'location': '101280101',
    }
    url = 'https://devapi.qweather.com/v7/weather/now'
    data = requests.get(url, params=params).json()
    weather = {}
    if data['code'] == '200':
        weather = {
            'city': '广州',
            'temperature': data['now']['temp'],
            'description': data['now']['text'],
            'icon': data['now']['icon']
        }
    return {'weather': weather}


@register.filter(name='timesince')
def timesince(date):
    now = timezone.now()
    diff = now - date

    if diff.days == 0 and 0 <= diff.seconds < 60:
        return ' 刚刚'
    if diff.days == 0 and 60 <= diff.seconds < 3600:
        return str(math.floor(diff.seconds / 60)) + " 分钟前"
    if diff.days == 0 and 3600 <= diff.seconds < 86400:
        return str(math.floor(diff.seconds / 3600)) + " 小时前"
    if 1 <= diff.days < 30:
        return str(diff.days) + " 天前"
    if 30 <= diff.days < 365:
        return str(math.floor(diff.days / 30)) + " 月前"
    if diff.days >= 365:
        return str(math.floor(diff.days / 365)) + " 年前"


# 判断分组
@register.filter('has_group')
def has_group(user, group_name):
    groups = user.groups.all().values_list('name', flat=True)
    return True if group_name in groups else False


# 自定义获取字典值过滤器
@register.filter
def get_item(dictionary, key):
    return dictionary.get(key)
