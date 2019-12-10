from django.db import models


class TodoItem(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=256, null=True, blank=True)
    completed = models.NullBooleanField(null=True, blank=True, default=False)
    url = models.CharField(max_length=256, null=True, blank=True)
    order = models.IntegerField(null=True, blank=True)
