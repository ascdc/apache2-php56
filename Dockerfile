FROM ubuntu:trusty
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh

RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /*.sh && \
	apt-get update && \
	apt-get -y install software-properties-common python-software-properties && \
	locale-gen en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	add-apt-repository -y ppa:ondrej/php && \
	add-apt-repository -y ppa:ondrej/apache2
RUN DEBIAN_FRONTEND=noninteractive && apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y apache2 php5.6 php5.6-common php5.6-json php5.6-opcache php5.6-zip php5.6-mysql php5.6-phpdbg php5.6-gd php5.6-imap php5.6-ldap php5.6-pgsql php5.6-pspell php5.6-recode php5.6-tidy php5.6-dev php5.6-intl php5.6-curl php5.6-mcrypt php5.6-xmlrpc php5.6-xsl php5.6-bz2 php5.6-mbstring pkg-config libmagickwand-dev imagemagick build-essential libapache2-mod-php5 && \
	echo 'autodetect'|pecl install imagick uploadprogress memcache && \
	echo "extension=imagick.so" | sudo tee /etc/php/5.6/mods-available/imagick.ini && \
	echo "extension=uploadprogress.so" | sudo tee /etc/php/5.6/mods-available/uploadprogress.ini && \
	echo "extension=memcache.so" | sudo tee /etc/php/5.6/mods-available/memcache.ini && \
	ln -sf /etc/php/5.6/mods-available/imagick.ini /etc/php/5.6/apache2/conf.d/20-imagick.ini && \
	ln -sf /etc/php/5.6/mods-available/uploadprogress.ini /etc/php/5.6/apache2/conf.d/20-uploadprogress.ini && \
	ln -sf /etc/php/5.6/mods-available/memcache.ini /etc/php/5.6/apache2/conf.d/20-memcache.ini && \
	ln -sf ../mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT ["/run.sh"]
