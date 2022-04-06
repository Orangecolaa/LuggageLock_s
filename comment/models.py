from django.db import models
from lock.models import Lock
from ckeditor.fields import RichTextField
from django.contrib.auth.models import User


# Create your models here.
class Comment(models.Model):
    lock = models.ForeignKey(
        Lock,
        on_delete=models.CASCADE,
        related_name='comments'
    )
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='commentss'
    )

    body = RichTextField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ('created_at',)

    def __str__(self):
        return self.body[:20]
