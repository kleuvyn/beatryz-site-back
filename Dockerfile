FROM rasa/rasa:3.6.21-full

WORKDIR /app

COPY . /app

COPY requirements.txt .

RUN pip install -r requirements.txt --no-cache-dir

RUN rasa train --data chat/data --domain chat/domain.yml --config chat/config.yml

ENV PORT=5005

EXPOSE 5005

CMD ["run", "-i", "0.0.0.0", "-p", "5005", "--model", "models", "--enable-api", "--cors", "*"]