from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('',
    #(r'^$', direct_to_template, {'template': 'home/index.html'}),
    url(r'^$', 'home.views.home', name="home"),
)
