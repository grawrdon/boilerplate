import os
import fabric
from random import Random
from getpass import getpass
from fabric.api import *
from fabric.operations import prompt


env.root_dir = os.path.abspath(os.path.dirname(__file__))
env.unit = os.path.split(env.root_dir)[1]
env.path = "~/apps/%(unit)s" % env
env.source = "git@bitbucket.com:tylerball/%(unit)s.git" % env
env.source_http = "https://tylerball@bitbucket.org/tylerball/%(unit)s.git" % env
env.django_root = os.path.join(env.root_dir, 'apps/')

env.pip_requirements = "requirements/common.txt"
env.pip_requirements_prod = "requirements/prod.txt"

rng = Random()
r_seed = "1234567890qwertyuiopasdfghjklzxcvbnm"
env.secret_key = ""
for i in range(30):
    env.secret_key += rng.choice(r_seed)

def echo(msg):
    local('echo %s' % msg)

def setup_localsettings():
    with hide('running'):
        env.password = getpass("Enter a password for your database")
        with lcd(env.django_root):
            echo("Creating settings_local.py")
            local("sed 's/<projectname>/%s/g' settings_local.py.ex > settings_local.py" % env.unit)
            local("sed 's/<password>/%s/g' settings_local.py > settings_local.py.1" % env.password)
            local("sed 's/<secretkey>/%s/g' settings_local.py.1 > settings_local.py")
            local("rm settings_local.py.1")

def setup_localdb():
    with hide('running'):
        local("createuser --no-createrole --no-superuser --createdb --pwprompt %s" % env.unit)
        local("createdb %(unit)s --owner %(unit)s" % env)
        local("echo '*:*:%(unit)s:%(unit)s:%(password)s' >> ~/.pgpass" % env)
        local("chmod 0600 ~/.pgpass")

def setup_localreqs():
    with hide('running'):
        echo('updating requirements')
        with lcd(env.root_dir):
            local('pip install -r %s' % env.pip_requirements)
            local('git submodule sync')
            local('git submodule init')
            local('git submodule update')

def test_all():
    with lcd(env.django_root):
        local('./manage.py test')

def setup_local():
    setup_localreqs()
    setup_localsettings()
    setup_localdb()
    test_all()

def getapp(app):
    local('pip install %s' % app)
    local('echo %s >> %s' % (app, env.pip_requirements[0]))
