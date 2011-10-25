# settings_local.py
# TODO: cp this file to settings_local.py and fill in the details

DEBUG = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': '',
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'PORT': '',
    }
}

ADMINS = (
    ('Tyler Ball', 'tyler@tylerball.net'),
)

# Make this unique, and don't share it with anybody.
SECRET_KEY = 'TODO:make_this_unique'

MEDIA_URL = '/media/'

STATIC_URL = MEDIA_URL + 'static/'

PIPELINE = False
PIPELINE_AUTO = False
PIPELINE_COMPILERS = (
    #'pipeline.compilers.less.LessCompiler',
)
