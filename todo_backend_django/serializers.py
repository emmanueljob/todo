from rest_framework import serializers
from todo_backend_django.models import TodoItem, Label



class LabelSerializer(serializers.ModelSerializer):
    id = serializers.ReadOnlyField()
    # items = TodoItemSerializer(many=True)
    label = serializers.CharField(max_length=256, required=False)
    
    class Meta:
        model = Label
        fields = ('id', 'label')


class TodoItemSerializer(serializers.ModelSerializer):
    id = serializers.ReadOnlyField()
    title = serializers.CharField(max_length=256, required=True)
    completed = serializers.BooleanField(required=False, default=False)
    url = serializers.CharField(max_length=256, required=False)
    order = serializers.IntegerField(required=False)
    labels = LabelSerializer(many=True, required=False)
    
    def validate_title(self, value):
        if value is None or value == "":
            raise serializers.ValidationError("Title cannot be empty")

        return value

    def create(self, validated_data):
        to_add = None
        if validated_data.get('labels'):
            to_add = []
            for l in validated_data.get('labels'):
                try:
                    label = Label.objects.get(label=l)
                except:
                    label = Label(label=l['label'])
                    label.save()
                    
                to_add.append(label)

            del validated_data['labels']
        todo_item = TodoItem(**validated_data)
        todo_item.save()
        if to_add:
            todo_item.labels.add(*to_add)
        return todo_item

    def update(self, instance, validated_data):
        instance.title = validated_data.get('title', instance.title)
        instance.completed = validated_data.get('completed', instance.completed)
        instance.url = validated_data.get('url', instance.url)
        instance.order = validated_data.get('order', instance.order)

        to_add = None
        if validated_data.get('labels'):
            to_add = []
            for l in validated_data.get('labels'):
                try:
                    label = Label.objects.get(label=l)
                except:
                    label = Label(label=l['label'])
                    label.save()
                    
                to_add.append(label)

            del validated_data['labels']

        instance.labels.clear()
        if to_add:
            instance.labels.add(*to_add)
        return instance
    
    class Meta:
        model = TodoItem
        fields = ('id', 'title', 'completed', 'url', 'order', 'labels')
