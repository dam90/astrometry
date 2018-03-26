#! /bin/bash

# add secrets:
cp -r secrets/ /astrometry.net/net/
# install astrometry python package:
cd /astrometry.net
# go into django dir:
cd net/
# link basic settings file:
ln -s settings_test.py settings.py
# make migrations:
python manage.py makemigrations
python manage.py migrate
python manage.py loaddata fixtures/*
# change allowed hosts in common settings file:
ORIGINAL_LINE_START="ALLOWED_HOSTS = \["
REPLACE_WITH="ALLOWED_HOSTS = \[\'\*\',"
sed -i "s/$ORIGINAL_LINE_START/$REPLACE_WITH/g" settings_common.py
# allow serving static files through wsgi by adding the the following lines to urls.py:
NEW_LINE="# Allow static file serving via wsgi app in Docker container:"
echo $NEW_LINE >> ./urls.py
NEW_LINE="from django.contrib.staticfiles.urls import staticfiles_urlpatterns"
echo $NEW_LINE >> ./urls.py
NEW_LINE="urlpatterns = staticfiles_urlpatterns() + urlpatterns"
echo $NEW_LINE >> ./urls.py
