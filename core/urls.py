"""core URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include  # add this
import notifications.urls

urlpatterns = [
    path('admin/', admin.site.urls),  # Django admin route
    path('auth/', include("authentication.urls")),  # Auth routes - login / register
    path('', include("lock.urls")),  # UI Kits Html files
    # path('api/', include('Api.urls')),
    path('comment/', include('comment.urls', namespace='comment')),
    path('inbox/notifications/', include(notifications.urls, namespace='notifications')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,
                          document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

handler400 = 'lock.views.HandleErrors.bad_request'
handler403 = 'lock.views.HandleErrors.permission_denied'
handler404 = 'lock.views.HandleErrors.page_not_found'
handler500 = 'lock.views.HandleErrors.server_error'
