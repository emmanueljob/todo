from rest_framework import serializers
from todo_backend_django.models import TodoItem


class TodoItemSerializer(serializers.ModelSerializer):
    id = serializers.ReadOnlyField()
    title = serializers.CharField(max_length=256, required=False)
    completed = serializers.BooleanField(required=False, default=False)
    url = serializers.CharField(max_length=256, required=False)
    order = serializers.IntegerField(required=False)

    def create(self, validated_data):
        return TodoItem(**validated_data)

    def update(self, instance, validated_data):
        instance.title = validated_data.get('title', instance.title)
        instance.completed = validated_data.get('completed', instance.completed)
        instance.url = validated_data.get('url', instance.url)
        instance.order = validated_data.get('order', instance.order)
        return instance
    
    class Meta:
        model = TodoItem
        fields = ('id', 'title', 'completed', 'url', 'order')
