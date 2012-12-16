# Development settings for news
from settings.base import *

DEBUG = True
TEMPLATE_DEBUG = DEBUG

# Change this to work with your default development database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',  # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
        'USER': 'madisonian',                       # Not used with sqlite3.
        'PASSWORD': 'o8685gtfqdyn8gy8573t',                   # Not used with sqlite3.
        'HOST': '127.0.0.1',                       # Set to empty string for localhost. Not used with sqlite3.
        'PORT': '',                       # Set to empty string for default. Not used with sqlite3.
        'NAME': 'madisonian',
        }
}

MIDDLEWARE_CLASSES += ('debug_toolbar.middleware.DebugToolbarMiddleware',)

INSTALLED_APPS += ('debug_toolbar',)

# URL configuration to use in development mode
ROOT_URLCONF = 'urls.production'
