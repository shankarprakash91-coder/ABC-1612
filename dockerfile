############################
# 3.a BASE STAGE
############################
FROM ubuntu:22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y cron

RUN useradd -m abc

RUN mkdir -p /data && \
    chown abc:abc /data

############################
# 3.b INTERMEDIATE STAGE
############################
FROM base AS intermediate

COPY manage.sh /usr/local/bin/manage.sh

RUN chmod +x /usr/local/bin/manage.sh

RUN echo "* * * * * abc /usr/local/bin/manage.sh 1" > /etc/cron.d/abc-cron

RUN chmod 0644 /etc/cron.d/abc-cron

############################
# 3.c CLEANUP STAGE
############################
FROM intermediate AS cleanup

RUN echo "* * * * * abc /usr/local/bin/manage.sh 0" > /etc/cron.d/cleanup-cron

############################
# 3.d CREATE STAGE
############################
FROM intermediate AS create

RUN echo "* * * * * abc /usr/local/bin/manage.sh 1" > /etc/cron.d/create-cron

CMD ["cron", "-f"]
