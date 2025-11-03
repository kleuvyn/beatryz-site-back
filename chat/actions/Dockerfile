FROM rasa/rasa:3.7.0-full

WORKDIR /app

COPY . /app

COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

RUN rasa train

EXPOSE 5005

CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug"]