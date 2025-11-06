FROM rasa/rasa:3.10.0-full AS build

USER root

COPY . /app

WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt

FROM rasa/rasa:3.10.0-full

WORKDIR /app

COPY --from=build /app /app

EXPOSE 5005

CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005", "--endpoints", "endpoints.yml"]
