FROM python:3.8-alpine

RUN apk update && apk upgrade && apk add git
RUN git init
RUN git remote add origin git@github.com:owner/backend-repo.git
RUN git fetch
RUN git checkout main
RUN git pull

ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install -r /requirements.txt
RUN apk del .tmp

RUN mkdir /src
COPY ./src src
WORKDIR /src

COPY ./scripts/ /scripts/

RUN chmod +x /scripts/*

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

RUN adduser -D dockeruser
RUN chown -R dockeruser:dockeruser /vol
RUN chmod -R 755 /vol/web

USER dockeruser

CMD ["entrypoint.sh"]