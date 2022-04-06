from django.shortcuts import get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from .forms import CommentForm
from lock.models import Lock
from django.http import HttpResponse


@login_required(login_url='login')
def Post_comment(request, lock_id):
    lock = get_object_or_404(Lock, id=lock_id)

    if request.method == 'POST':
        comment_form = CommentForm(request.POST)
        if comment_form.is_valid():
            new_comment = comment_form.save(commit=False)
            new_comment.lock = lock
            new_comment.user = request.user
            new_comment.save()
            return redirect('book_detail', pk=lock_id)
        else:
            return HttpResponse("格式错误，请重新填写！")
    # 处理错误请求
    else:
        return HttpResponse("评论只接受POST请求！")
