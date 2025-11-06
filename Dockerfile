FROM rasa/rasa-sdk:<SDK_VERSION>

WORKDIR /app

COPY actions/requirements-actions.txt ./

USER root

RUN pip install -r requirements-actions.txt

COPY ./actions /app/actions

USER 1001

CMD ["rasa", "run", "actions"]
