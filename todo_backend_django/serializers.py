from rest_framework import serializers
from todo_backend_django.models import TodoItem


class TodoItemSerializer(serializers.ModelSerializer):
    pk = serializers.ReadOnlyField()
    title = serializers.CharField(max_length=256, required=False)
    completed = serializers.BooleanField(required=False, default=False)
    url = serializers.CharField(max_length=256, required=False)
    order = serializers.IntegerField(required=False)

    def restore_object(self, attrs, instance=None):
        if instance:
            instance.title = attrs.get('title', instance.title)
            instance.completed = attrs.get('completed', instance.completed)
            instance.url = attrs.get('url', instance.url)
            instance.order = attrs.get('order', instance.order)
            return instance
        return TodoItem(**attrs)

    class Meta:
        model = TodoItem
        fields = ('pk', 'title', 'completed', 'url', 'order')
