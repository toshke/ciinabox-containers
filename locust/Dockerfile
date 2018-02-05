FROM python:alpine

RUN apk --update add tzdata g++ make bash \
  && pip install locustio awscli \
  && apk del make \
  && rm -rf /var/cache/apk/* /root/__pycache__

WORKDIR /src
COPY entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT '/bin/entrypoint.sh'

# pull locust file
