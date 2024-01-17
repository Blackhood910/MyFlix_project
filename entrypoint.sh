#!/bin/sh
# Your initial command1
docker-compose exec web python manage.py flush --no-input

# Your initial command2
docker-compose exec web python manage.py migrate

# Your initial command3
python manage.py runserver 0.0.0.0:8000

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

#python manage.py flush --no-input
#python manage.py migrate

exec "$@"
