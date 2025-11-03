FROM rasa/rasa:3.6.21-full

WORKDIR /app

COPY . /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt || true

RUN rasa train --data chat/data --domain chat/domain.yml --config chat/config.yml

ENV PORT=${PORT:-8080}

EXPOSE $PORT

CMD ["run", "--enable-api", "--cors", "*", "--host", "0.0.0.0", "--port", "8080"]
