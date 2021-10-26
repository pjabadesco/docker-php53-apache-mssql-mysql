FROM pjabadesco/php53-apache-mssql-mysql:latest

ADD php.ini /etc/php53/apache2/php.ini
COPY --chown=root:staff public/ /var/www/html/
RUN chmod 777 /var/www/html/amember/data/new_rewrite -R 