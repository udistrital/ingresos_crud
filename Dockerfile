FROM python:3
RUN pip install awscli
WORKDIR /
COPY entrypoint.sh main conf/app.conf ./
ENTRYPOINT ["/entrypoint.sh"]
