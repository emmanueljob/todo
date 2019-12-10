from django.conf.urls import include, url

from django.views.generic import RedirectView
from rest_framework.urlpatterns import format_suffix_patterns
from todo_backend_django import views



urlpatterns = [
               url(r'^$', RedirectView.as_view(url='/todos')),
               url(r'^todos$', views.TodoList.as_view()),
               url(r'^todo/(?P<id>[0-9]+)$', views.Todo.as_view()),
               ]


