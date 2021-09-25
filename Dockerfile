FROM debian:bullseye
LABEL maintainer "Rainer Bendig <hexathos@mailbox.org>"

RUN apt-get update && apt-get install -y \
		apt-transport-https \
		lsb-release \
		ca-certificates \ 
		curl \
		apt-utils
		
RUN curl https://packages.sury.org/php/apt.gpg -o /etc/apt/trusted.gpg.d/sury-php.gpg

RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

RUN apt-get update

RUN apt-get install -y $(apt-cache search php8.0 | cut -d " " -f 1 |grep -v 'dbgsym\|apache\|-imagick\|apc\|fpm\|-cgi\|xdebug')

RUN apt-get clean

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin && php -r "unlink('composer-setup.php');"

CMD [ "bash" ]
