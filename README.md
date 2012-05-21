django-boilerplate
==================

This is an attempt to create a boilerplate starting template for my django projects.

----

Included stuff
--------------

* [django-pipeline][pipe] for serving assets.
* Base template that incorporates some things from [HTML5 Boilerplate][h5b]
* A basic build of [Modernizr][mdnzr] with Modernizr.load in the base template. (TODO)
* Twitter's [bootstrap][boot] for kicking off good-looking sites.
* A copy of jQuery 1.6.2 loaded with Modernizr via CDN.

----

Requirements
------------

* PostgreSQL
* Python 2.6+ (probably)
* pip (easy\_install pip)
* [virtualenv][venv] and [virtualenvwrapper][venvw].
* vagrant (optional, but better)

**On the server**:

* yuicompressor
* gunicorn
* nginx

Installation
------------

    mkvirtualenv boilerplate
    cd $VIRTUAL_ENV
    git init
    git remote add origin git@github.com:tylerball/django-boilerplate.git
    git pull origin master
    vagrant up

----

Todo:
----

* Automate server setup, e.g. copying over all the configs, generating a
  supervisor script.
* document server setup
* moar fabric stuff
* finish integrating Modernizr
* automate nodejs install for vagrant

Inspiration
-----------

Bueda's [django-boilerplate][bueda]

[h5b]:http://html5boilerplate.com/
[mdnzr]:http://www.modernizr.com/
[pipe]:https://github.com/cyberdelia/django-pipeline
[boot]:https://github.com/twitter/bootstrap
[venv]:http://www.virtualenv.org/en/latest/index.html
[venvw]:http://www.doughellmann.com/docs/virtualenvwrapper/
[bueda]:https://github.com/bueda/django-boilerplate

