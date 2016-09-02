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
RUN service mysql stop
RUN sed -i "s|/var/run/mysqld/|/run/mysqld/|g" /etc/mysql/my.cnf
RUN cd /usr ; /usr/bin/mysqld_safe &
RUN /usr/bin/mysqladmin -u root password 'password1'
RUN    mysql -u root -proot -e "DELETE FROM mysql.user WHERE User='';"
RUN  mysql -u root -proot -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1');"
RUN    mysql -u root -proot -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
RUN    mysql -u root -proot -e "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;"
RUN    mysql -u root -proot -e "CREATE DATABASE drupaldb DEFAULT CHARACTER SET utf8;"
RUN    mysql -u root -proot -e "GRANT ALL PRIVILEGES ON drupaldb.* TO drupal@'%' IDENTIFIED BY 'password1' WITH GRANT OPTION;"
RUN    mysql -u root -proot -e "CREATE DATABASE civicrm DEFAULT CHARACTER SET utf8;"
RUN    mysql -u root -proot -e "GRANT ALL PRIVILEGES ON civicrm.* TO civicrm@'%' IDENTIFIED BY 'password1' WITH GRANT OPTION;"
RUN    mysql -u root -proot -e "FLUSH PRIVILEGES;"
RUN    cd /usr ; /usr/bin/mysqld_safe &
EXPOSE 80 443 3306
ENTRYPOINT ["/bin/bash"]
RUN  service mysql restart
