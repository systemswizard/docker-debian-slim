FROM docker.io/library/debian:bookworm-slim
LABEL org.opencontainers.image.authors="github.com/systemswizard"
LABEL org.opencontainers.image.description="debian bookworm slim docker image"
LABEL org.opencontainers.image.source="https://github.com/systemswizard/docker-debian-slim"
LABEL org.opencontainers.image.url="https://github.com/systemswizard/docker-gh-actions-runner/pkgs/container/debian-slim"
LABEL org.opencontainers.image.documentation="https://github.com/systemswizard/docker-debian-slim"
LABEL org.opencontainers.image.vendor="systemswizard"
ENV DEBIAN_FRONTEND=noninteractive
COPY apt.conf-01norecommend /etc/apt/apt.conf.d/01norecommend
COPY apt.conf-sources.list /etc/apt/sources.list
RUN  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && apt-get update && apt-get -y upgrade && apt-get -y install locales procps apt-utils
RUN  touch /etc/locale.gen && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen 
RUN  apt-get -y install --reinstall ca-certificates && rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
