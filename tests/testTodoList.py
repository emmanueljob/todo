import json
import django
django.setup()

import unittest
from rest_framework.test import APIRequestFactory
from todo_backend_django import settings
from todo_backend_django.views import Todo
from todo_backend_django import models
from todo_backend_django.views import TodoList



class TestTodoList(unittest.TestCase):

    def setUp(self):
        pass
    
    def testPost(self):
        # Using the standard RequestFactory API to create a form POST request
        factory = APIRequestFactory()
        request = factory.post('/todos/', {'title': 'eman'}, format='json')
        view = TodoList.as_view()
        response = view(request, None)
        obj = json.loads(response.content)

        assert obj.get('title') == 'eman'
        assert obj.get('id') is not None
        assert obj.get('id') > 0


    def testPostEmptyTitle(self):
        # Using the standard RequestFactory API to create a form POST request
        factory = APIRequestFactory()
        request = factory.post('/todos/', {'title': ''})
        view = TodoList.as_view()
        response = view(request, None)
        assert response.status_code == 400

    def testLabelsPost(self):
        # Using the standard RequestFactory API to create a form POST request
        factory = APIRequestFactory()
        my_r = {
            'title': 'alto',
            'labels': [{ 'label': 'one'}, { 'label': 'two'}]
        }
        request = factory.post('/todos/', my_r, format='json')
        view = TodoList.as_view()
        response = view(request, None)
        
        obj = json.loads(response.content)
        assert len(obj.get('labels')) == 2

        
    def testGet(self):
        todo = models.TodoItem(title='eman2')
        todo.save()

        factory = APIRequestFactory()
        request = factory.get('/todos/')
        view = TodoList.as_view()
        response = view(request, None)
        response_list = json.loads(response.content)

        obj = response_list[0]
        assert obj.get('title') == "eman2"
        
