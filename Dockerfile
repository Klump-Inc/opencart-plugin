FROM php:8.2.11-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libxslt1-dev \
    libzip-dev \
    libonig-dev \
    libcurl4-gnutls-dev \
    libicu-dev \
	wget \
	unzip \
	zip \
	zlib1g-dev \
	libc-client-dev \
	libkrb5-dev \
	ghostscript \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) bcmath exif gd intl mbstring mysqli soap xml xsl zip pdo fileinfo pdo_mysql \
    && a2enmod rewrite headers \
    && service apache2 restart

ENV DIR_OPENCART='/var/www/html/'
ENV DIR_STORAGE='/storage/'
ENV DIR_CACHE=${DIR_STORAGE}'cache/'
ENV DIR_DOWNLOAD=${DIR_STORAGE}'download/'
ENV DIR_LOGS=${DIR_STORAGE}'logs/'
ENV DIR_SESSION=${DIR_STORAGE}'session/'
ENV DIR_UPLOAD=${DIR_STORAGE}'upload/'
ENV DIR_IMAGE=${DIR_OPENCART}'image/'

WORKDIR /var/www/html


RUN curl -Lo /var/www/html/opencart.zip "https://github.com/opencart/opencart/releases/download/4.0.2.3/opencart-4.0.2.3.zip"

RUN apt-get install -y unzip \
    && unzip /var/www/html/opencart.zip '*/upload/*' -d /var/www/html/ \
    && mv /var/www/html/opencart-*/upload/* /var/www/html/ \
    && rm -rf /var/www/html/opencart* \
    && cp /var/www/html/config-dist.php /var/www/html/config.php \
    && cp /var/www/html/admin/config-dist.php /var/www/html/admin/config.php \
    && chown -R www-data:www-data /var/www/ \
	&& cp /var/www/html/php.ini /usr/local/etc/php

# RUN mv ${DIR_OPENCART}system/storage/* /storage
# COPY configs ${DIR_OPENCART}
COPY php.ini ${PHP_INI_DIR}

RUN rm -rf /var/www/html/install

RUN a2enmod rewrite

#RUN chown -R www-data:www-data ${DIR_STORAGE}
#RUN chmod -R 555 ${DIR_OPENCART}
#RUN chmod -R 666 ${DIR_STORAGE}
#RUN chmod 555 ${DIR_STORAGE}
#RUN chmod -R 555 ${DIR_STORAGE}vendor
#RUN chmod 755 ${DIR_LOGS}
#RUN chmod -R 644 ${DIR_LOGS}*

#RUN chown -R www-data:www-data ${DIR_IMAGE}
#RUN chmod -R 744 ${DIR_IMAGE}
#RUN chmod -R 755 ${DIR_CACHE}

#RUN chmod -R 666 ${DIR_DOWNLOAD}
#RUN chmod -R 666 ${DIR_SESSION}
#RUN chmod -R 666 ${DIR_UPLOAD}
