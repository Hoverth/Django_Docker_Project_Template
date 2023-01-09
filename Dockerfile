###########
# BUILDER #
###########

# pull official base image
FROM python:3.10-alpine as builder

# set work directory
WORKDIR /project

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN apk update \
    && apk add postgresql-dev libc-dev gcc g++ python3-dev musl-dev make

RUN pip install --upgrade pip

COPY . .

# install dependencies
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /project/wheels -r requirements.txt

#########
# FINAL #
#########
FROM python:3.10-alpine

RUN mkdir /home/project

RUN addgroup -S project && adduser -S project -G project

ENV HOME=/home/project
WORKDIR $HOME
RUN mkdir $HOME/static

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apk update && apk add libpq g++ libc-dev
COPY --from=builder /project/wheels /wheels
COPY --from=builder /project/requirements.txt .
RUN pip install --no-cache /wheels/*

COPY . $HOME

COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g'  $HOME/entrypoint.sh
RUN chmod +x  $HOME/entrypoint.sh

RUN chown -R project:project $HOME
RUN chown -R project:project $HOME/static

USER project

ENTRYPOINT ["/home/project/entrypoint.sh"]
