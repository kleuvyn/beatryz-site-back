FROM rasa/rasa:3.6.21-full

WORKDIR /app

COPY . /app

COPY requirements.txt .

RUN pip install -r requirements.txt --no-cache-dir

RUN rasa train --data chat/data --domain chat/domain.yml --config chat/config.yml

EXPOSE 5005

CMD rasa run --model models --enable-api --cors "*" --host 0.0.0.0 --port $PORT