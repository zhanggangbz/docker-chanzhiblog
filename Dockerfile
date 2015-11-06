FROM ubuntu:trusty

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install unzip supervisor apache2 libapache2-mod-php5 php5-mysql pwgen php-apc php5-mcrypt && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Configure /app folder with sample app
# RUN wget http://llii.file.alimmdn.com/chanzhi.zip
# RUN unzip chanzhi.zip -d /app/
# RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
# RUN chmod -R 777 /app
# RUN chmod -R 777 /var/www/html
# RUN chown -R www-data:www-data /app /var/www/html

#Enviornment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 50M
ENV PHP_POST_MAX_SIZE 50M
ENV AUTHORIZED_KEYS **None**

# Add volumes for MySQL 
VOLUME  ["/app" ]
EXPOSE 80
CMD ["/run.sh"]
