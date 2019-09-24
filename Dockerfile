FROM alpine:latest

RUN apk add \
curl \
nginx \
php7 \
php7-curl \
php7-fpm \
php7-gd \
php7-mbstring \
php7-mcrypt \
php7-mysqli \
php7-xml \
php7-zip \
supervisor \
tzdata \
&& rm -f /etc/nginx/nginx.conf \
&& rm -rf /var/www/localhost \
&& mkdir -p /var/lib/php7/session \
&& mkdir -p /var/lib/php7/wsdlcache \
&& cp /usr/share/zoneinfo/Europe/Istanbul /etc/localtime

COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/php-fpm.d/www.conf /etc/php7/php-fpm.d/www.conf 
COPY etc/supervisord.conf /etc/

VOLUME /var/www

EXPOSE 8080

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
