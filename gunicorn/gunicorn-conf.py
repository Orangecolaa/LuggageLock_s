import multiprocessing
bind = 'unix:///tmp/gunicorn1.sock'
workers = multiprocessing.cpu_count() * 2 + 1
reload = True
daemon = True
