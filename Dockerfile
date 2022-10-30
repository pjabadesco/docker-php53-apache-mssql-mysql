FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common curl && \
    add-apt-repository -y ppa:sergey-dryabzhinsky/php53 && \
    add-apt-repository -y ppa:sergey-dryabzhinsky/packages && \
    add-apt-repository -y ppa:sergey-dryabzhinsky/php-modules && \
    apt-get update 

RUN apt-get install -y \
    wget apache2 libapache2-mod-php53 apache2-mpm-prefork postfix zip

# RUN apt-get install -y \
#     php53-common \
#     php53-cli \
#     php53-mod-gd \
#     php53-mod-mysql \
#     php53-mod-bcmath \
#     php53-mod-calendar \
#     php53-mod-bz2 \
#     php53-mod-soap \
#     php53-mod-xml \
#     php53-mod-xmlreader \
#     php53-mod-xmlwriter \
#     php53-mod-ftp \
#     php53-mod-imap \
#     php53-mod-dom \
#     php53-mod-exif \
#     php53-mod-fileinfo \
#     php53-mod-gettext \
#     php53-mod-gmp \
#     php53-mod-json \
#     php53-mod-mbstring \
#     php53-mod-openssl \
#     php53-mod-phar \
#     php53-mod-pcntl \
#     php53-mod-simplexml \
#     php53-mod-curl \
#     php53-mod-readline \
#     php53-mod-tokenizer \
#     php53-mod-wddx \
#     php53-mod-xsl 

RUN apt-get install -y \
    php53-common \
    php53-cli \
    # php53-mod-apc \
    # php53-mod-bcmath \
    php53-mod-bz2  \
    php53-mod-calendar \
    php53-mod-curl \
    php53-mod-dba \
    php53-mod-dom \
    php53-mod-exif \
    php53-mod-fileinfo \
    php53-mod-ftp \
    php53-mod-gd \
    php53-mod-geoip \
    php53-mod-gettext \
    php53-mod-gmp \
    php53-mod-gnupg 
# php53-mod-igbinary \
# php53-mod-igbinary-dev \
# php53-mod-imagick \
# php53-mod-imap \
# php53-mod-intl \
# php53-mod-ioncubeloader-bin 

RUN apt-get install -y \
    php53-mod-json \
    #php53-mod-jsonc \
    # php53-mod-ldap \
    php53-mod-mbstring \
    php53-mod-mcrypt \
    php53-mod-memcache \
    # php53-mod-memcached  \
    php53-mod-mongo \
    php53-mod-mssql  \
    php53-mod-mysql \
    # php53-mod-mysqlnd \
    php53-mod-odbc \
    php53-mod-opcache \
    php53-mod-openssl \
    # php53-mod-pgsql \
    php53-mod-phar  \
    php53-mod-posix \
    php53-mod-pspell \
    # php53-mod-rar \
    php53-mod-readline \
    # php53-mod-recode \
    php53-mod-redis 

RUN apt-get install -y \
    php53-mod-simplexml \
    # php53-mod-snappy \
    # php53-mod-snmp \
    php53-mod-soap \
    php53-mod-sqlite \
    php53-mod-ssh2 \
    # php53-mod-stomp \
    # php53-mod-templates \
    # php53-mod-tidy \
    php53-mod-timezonedb \
    php53-mod-tokenizer \
    php53-mod-wddx \
    # php53-mod-xcache \
    # php53-mod-xdebug \
    # php53-mod-xdebug-doc \
    php53-mod-xml \
    php53-mod-xmlreader \
    php53-mod-xmlrpc \
    php53-mod-xmlwriter \
    php53-mod-xsl \
    php53-mod-zip \
    # php53-mod-zstd \
    php53-pear \
    php53-pecl \
    php53-phar 

RUN set -ex && \
    wget https://github.com/Distrotech/PDFlib-Lite/archive/refs/heads/master.zip && \
    unzip master.zip && cd PDFlib*master && \
    ./configure && make && make install && \
    wget http://pecl.php.net/get/pdflib-2.1.8.tgz && \
    tar -zxf pdflib-2.1.8.tgz && \
    mv pdflib-2.1.8 pdflib-pecl-2.1.8 && \
    cd pdflib-pecl-2.1.8 && \
    phpize && ./configure --with-pdflib && make && make install && \
    sudo ldconfig

RUN mkdir -p /var/lock/apache2 && mkdir -p /var/run/apache2 \
    && a2dismod mpm_event && a2enmod mpm_prefork

COPY conf/httpd.conf /etc/apache2/sites-available/000-default.conf
COPY conf/run /usr/local/bin/run

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN chmod +x /usr/local/bin/run && \
    a2enmod rewrite php53 remoteip && \
    rm -rf /etc/php53/cli/conf.d /etc/php53/apache2/conf.d && \
    ln -s /etc/php53/conf.d /etc/php53/cli/conf.d && \
    ln -s /etc/php53/conf.d /etc/php53/apache2/conf.d

ADD conf/php.ini /etc/php53/apache2/php.ini
COPY conf.d/ /etc/php53/apache2/conf.d/

# ADD conf/libpdf_php.so /usr/lib/php53/extensions/

RUN chmod 755 /var/www/html -R && \
    rm /var/www/html/index.html
COPY --chown=root:staff www/ /var/www/html/

EXPOSE 80
CMD ["/usr/local/bin/run"]