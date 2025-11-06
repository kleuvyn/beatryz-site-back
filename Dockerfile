FROM rasa/rasa:latest AS build

USER root

COPY . /app

WORKDIR /app

USER 1001

EXPOSE 5005

