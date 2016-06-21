FROM ubuntu:trusty
MAINTAINER ASCDC <asdc.sinica@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive && apt-get -y install software-properties-common python-software-properties
RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && add-apt-repository -y ppa:ondrej/php
RUN apt-get update && apt-get -y upgrade && apt-get install -y apache2 php5 php5-common php5-json php5-mysql php5-gd php5-imap php5-ldap php5-pgsql php5-pspell php5-recode php5-tidy php5-intl php5-gd php5-curl php5-mcrypt php5-xmlrpc php5-xsl php5-imagick imagemagick

ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT ["/run.sh"]