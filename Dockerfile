FROM ubuntu
MAINTAINER Umer Altaf <umeraltaf@gmail.com>

ENV TERM xterm

RUN apt-get update
RUN apt-get install -y software-properties-common

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server ca-certificates curl wget git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd \
  && mkdir /ubuntu/.ssh \
  && chmod 700 /ubuntu/.ssh \
  && touch /ubuntu/.ssh/authorized_keys

#RUN mkdir -p /pod-ssh/data

COPY scripts/* /usr/local/bin/
COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]