#!/bin/bash

VOLUME_HOME="/app"

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini
if [[ ! -d $VOLUME_HOME/data ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    wget http://llii.file.alimmdn.com/chanzhi.zip
	unzip chanzhi.zip -d /app/
	mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
	chmod -R 777 /app
	chmod -R 777 /var/www/html
	chown -R www-data:www-data /app /var/www/html
    echo "=> Done!"  
else
    echo "=> Using an existing volume of MySQL"
fi

exec supervisord -n
