import os
from celery import Celery

os.environ.setdefault('FORKED_BY_MULTIPROCESSING', '1')

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Project.settings')
app = Celery('Project')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()
