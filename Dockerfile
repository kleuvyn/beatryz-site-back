FROM rasa/rasa:<RASA_VERSION>-full

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

CMD ["rasa", "run", "--enable-api", "--cors", "*"]
