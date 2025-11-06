FROM rasa/rasa:latest

USER root

WORKDIR /app
COPY . /app

EXPOSE 5005

USER 1001

CMD ["run", "--enable-api", "--cors", "*", "--host", "0.0.0.0", "--port", "5005"]
