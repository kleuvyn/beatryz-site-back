FROM docker.io/rasa/rasa:3.6.21-full@sha256:5d6fe923a03dd01f022e3f598f39f25eb39db418c5f49bcd250db0d93cb0003c

WORKDIR /app

COPY requirements.txt .
COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

RUN rasa train --data chat/data --domain chat/domain.yml --config chat/config.yml

EXPOSE 5005

CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port ${PORT:-5005} --host 0.0.0.0"]