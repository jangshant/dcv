FROM ubuntu:14.04
MAINTAINER JANGSHANT SINGH <mail@jangshant.com>
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN apt-get update
RUN apt-get install -y mysql-server
RUN  rm -rf /var/lib/apt/lists/*
RUN  mysql_install_db
RUN  service mysql restart
RUN  service mysql restart
RUN mysql_secure_installation && \
          && \
        y && \
        password1 && \
        password1 && \
        y && \
        y && \
        y && \
        y
EXPOSE 80 443
ENTRYPOINT ["/bin/bash"]
RUN  service mysql restart
