FROM docker.io/rasa/rasa:3.6.21-full@sha256:5d6fe923a03dd01f022e3f598f39f25eb39db418c5f49bcd250db0d93cb0003c

WORKDIR /app

COPY . /app
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN rasa train --data chat/data --domain chat/domain.yml --config chat/config.yml

ENV PORT=${PORT:-8000}
EXPOSE $PORT

CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port $PORT --host 0.0.0.0"]
