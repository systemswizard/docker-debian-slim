FROM docker.io/library/debian:bookworm-slim
LABEL org.opencontainers.image.authors="github.com/systemswizard"
LABEL org.opencontainers.image.description="debian slim image for docker container images"
LABEL org.opencontainers.image.source="https://github.com/systemswizard/docker-debian-slim"
LABEL org.opencontainers.image.url="https://github.com/systemswizard/docker-debian-slim"
LABEL org.opencontainers.image.documentation="https://github.com/systemswizard/docker-debian-slim"
LABEL org.opencontainers.image.vendor="systemswizard"
# Make debian apps like apt not prompt for choices, uses default values provided by pkg maintainer or retains customizations if any
ENV DEBIAN_FRONTEND=noninteractive
# Makes apt not install additional binaries to keep image small
RUN  cat > /etc/apt/apt.conf.d/01norecommend << EOF \ APT::Install-Recommends "0"; \ APT::Install-Suggests "0"; \ EOF
RUN  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN  echo "deb http://deb.debian.org/debian bookworm contrib non-free non-free-firmware \n deb http://deb.debian.org/debian bookworm-backports contrib non-free non-free-firmware" >> /etc/apt/sources.list
RUN  apt-get update && apt-get -y upgrade
RUN  apt-get -y install locales procps apt-utils
RUN  touch /etc/locale.gen
RUN  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN  locale-gen
RUN  apt-get -y install --reinstall ca-certificates
RUN  rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8