# Django Docker Project Template
This is a template for a Django webserver within a Docker container, with several additional helpful components already set up.

## Usage
Just `git clone` this repository, and you should be good to go!

The Django project is held within the `Project` directory, with a default blank starting app in the `MainApp` subdirectory.

##### Make sure to change the variables in `.env`!!!

### Basic Command Reference
Here's some commands to get you started.

 - `docker-compose up -d --build` - Build and run the project, accessible by going to http://localhost:1337/
 - `docker-compose exec web python Project/manage.py shell` - Access the Django project built-in shell
 - `docker-compose logs web` - Shows the Django webserver's logs

## Components
This template contains the following components:

 - Django webserver
   - A empty Django project with a single blank app, with the only modifications the addition of the `celery.py` and `tasks.py` files and modification in the app's `__init__.py` to ease implementation of Celery tasks
 - PostgreSQL database
   - This database is already connected to Django, and is ready to be used
 - Celery task manager
   - This is to enable the implementation of asynchronous and/or scheduled tasks 
 - RabbitMQ message broker
   - This is to enable the Celery worker process to receive messages from the Django webserver
 - nginx reverse proxy
   - This is to serve the Django webserver coupled with its static files to the outside network

## License
Copyright (c) 2023 Thomas Dickson

This repository is licensed under the MIT license.

