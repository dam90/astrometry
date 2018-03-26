#! /bin/bash
echo "starting django wsgi app in gunicorn..."
# python manage.py runserver 0.0.0.0:8000 &
gunicorn net.wsgi:application -b 0.0.0.0:8000 &
echo "starting solve processor..."
python process_submissions.py --solve-locally=$(pwd)/solve_script.sh
