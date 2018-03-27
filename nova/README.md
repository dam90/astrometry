# Configuring Nova for Docker

This stuff configures the Nova server on top of a CentOS 7 docker image that with astrometry.net installed (see [astrometry](../astrometry) for details).

## Overview

The install script [install_nova.sh](./install_nova.sh) assumes the astrometry.net installation left a cloned git repository at `/astrometry.net/` in the container.  All the Nova code should reside in `/astrometry.net/net/`.

Nova is a Django app, but it uses an older version of Django (at the time of this doc, anyway).  It took some digging to understand how it is intended to be configured.  The docs are not very clear along these lines, but then again I'm not entitled to detailed docs.

## Nova Config Tutorial
Here's brief Nova configuration tutorial.  [install_nova.sh](./install_nova.sh) performs all these steps for basic configuration (no real authentication, just anonymous submissions).  I had success using Django version `django==1.7` but other versions may work as well.

### 1) go into the nova directory
In our case it's here:

`cd /astrometry.net/net`

### 2) create secrets directory
Some key django settings are included in the [secrets directory](./secrets).  This is typically used to configure authentication.  

`cp -r secrets/ /astrometry.net/net/`

### 3) symlink a settings file
Symlink one of the provided settings files to `settings.py`, which is where django typically looks for settings.  In my case, I don't care about authentication, so we use the provided `settings_test.py`.  *Note that all the example "settings_" files import `settings_common.py` where all the rest of the Nova configuration happens.*

`ln -s settings_test.py settings.py`

### 4) prepare django database
Lastly, create the django database, and load the initial data:

```
python manage.py makemigrations
python manage.py migrate
python manage.py loaddata fixtures/*
```

### 5) run the development server

Run the following and check for results at http://localhost:8000

`python manage.py runserver 0.0.0.0:8000`

## Optional Configuration steps

Here are some extra steps I use to run the Nova server as a WSGI application inside the docker container.

### Modify Allowed Hosts

Django will block requests to Nova that do not originate from hosts listed in the `ALLOWED_HOSTS` variable in `settings_common.py`.  This is good in production, where the application sits behind a proxy, but it's annoying for me.  I go into `settings_common.py` and add the wildcard `['*']` which will accept requests from any hosts.  You could always add your own lists of specific hosts.  Something like this:

`ALLOWED_HOSTS = ['*']`

### modify static files for serving via WSGI
I serve the application using [gunicorn](http://gunicorn.org/) since it's simple and light-weight.  It requires that I slightly modify the django app to allow me to serve static files.  I add the following to `settings_common.py`:

```
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
urlpatterns = staticfiles_urlpatterns() + urlpatterns
```

### use gunicorn HTTP server

Make sure you have gunicron installed (`pip install gunicorn`).  From the Nova django directory (`/usr/local/astrometry/net/` in my case):

`gunicorn net.wsgi:application -b 0.0.0.0:8000`

See if you get a response at http://localhost:8000.  If so you can daemonize the server like this:

`gunicorn net.wsgi:application -b 0.0.0.0:8000 -d`

Or add `&` to keep logging in the foreground:

`gunicorn net.wsgi:application -b 0.0.0.0:8000 &`

## Starting The solve_script

With the Nova server running, you need to start the solver.  The Nova server is designed to SSH into a remote server, solve, and bring the results back.  Alternatively it can be configured to run a local `astrometry_engine`.  I obviously want to solve locally, so I wrote [solve_script.sh](./solve_script.sh) which is provided as an input `process_submissions.py`.  From within the Nova directory I run:

`python process_submissions.py --solve-locally=$(pwd)/solve_script.sh`
