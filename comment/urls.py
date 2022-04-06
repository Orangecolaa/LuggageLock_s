from django.urls import path
from . import views

app_name = 'comment'

urlpatterns = [
    path('post-comment/<int:lock_id>/', views.Post_comment, name='post_comment'),
]