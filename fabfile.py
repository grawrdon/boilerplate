import os
from fabric.api import *


env.unit = "TODO"
env.path = "~/apps/%(unit)s" % env
env.source = "git@bitbucket.com:tylerball/%(unit)s.git" % env
env.source_http = "https://tylerball@bitbucket.org/tylerball/%(unit)s.git" % env
env.root_dir = os.path.abspath(os.path.dirname(__file__))
env.django_root = os.path.join(env.root_dir, 'apps/')

env.pip_requirements = ["requirements/common.txt"]
env.pip_requirements_prod = ["requirements/prod.txt"]

def test():
    with lcd(env.django_root):
        local('./manage.py test')
