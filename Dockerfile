FROM python:3.8-alpine

LABEL maintainer="dev@ivanne.de"

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install -r /requirements.txt
RUN apk del .tmp

COPY . ./

RUN chmod +x *.sh

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

RUN adduser -D dockeruser
RUN chown -R dockeruser:dockeruser /vol
RUN chmod -R 755 /vol/web

USER dockeruser

CMD ["entrypoint.sh"]