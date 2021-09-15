FROM python:3.8.7

LABEL maintainer="dev@ivanne.de"

ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
RUN apt update && \
  apt install -y && \
  pip3 install uwsgi
COPY . ./

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN chmod -R 755 /vol/web

#RUN adduser -D dockeruser
#RUN chown -R dockeruser:dockeruser /vol
#USER dockeruser

CMD ["entrypoint.sh"]