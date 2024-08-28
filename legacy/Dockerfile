FROM registry.nestybox.com/nestybox/ubuntu-bionic-systemd-docker:latest
MAINTAINER Umer Altaf <umeraltaf@gmail.com>

ENV TERM xterm

RUN mkdir /pod-ssh

RUN chgrp -R 0 /pod-ssh && \
    chmod -R g=u /pod-ssh

RUN apt-get update
RUN apt-get install -y software-properties-common

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server ca-certificates curl wget git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd \
  && mkdir /root/.ssh \
  && chmod 700 /root/.ssh \
  && touch /root/.ssh/authorized_keys

#RUN mkdir -p /pod-ssh/data

COPY scripts/* /usr/local/bin/
COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]