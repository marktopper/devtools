FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /var/app

RUN apt-get update -yqq
RUN apt-get upgrade -yqq
RUN apt install -yqq \
	curl \
	software-properties-common \
	git \
	unzip \
	docker-compose \
	xvfb \
	libgtk-3-dev \
	libnotify-dev \
	libgconf-2-4 \
	libnss3 \
	libxss1 \
	libasound2

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash

# Install PHP v7.3
RUN add-apt-repository ppa:ondrej/php --yes
RUN apt-get install -yqq \
	php7.3 \
	php7.3-bcmath \
	php7.3-bz2 \
	php7.3-cgi \
	php7.3-cli \
	php7.3-common \
	php7.3-curl \
	php7.3-dba \
	php7.3-enchant \
	php7.3-fpm \
	php7.3-gd \
	php7.3-gmp \
	php7.3-imap \
	php7.3-interbase \
	php7.3-intl \
	php7.3-json \
	php7.3-ldap \
	php7.3-mbstring \
	php7.3-mysql \
	php7.3-odbc \
	php7.3-opcache \
	php7.3-pgsql \
	php7.3-phpdbg \
	php7.3-pspell \
	php7.3-readline \
	php7.3-recode \
	php7.3-snmp \
	php7.3-soap \
	php7.3-sqlite3 \
	php7.3-sybase \
	php7.3-tidy \
	php7.3-xml \
	php7.3-xmlrpc \
	php7.3-zip \
	php-tokenizer
RUN php -v

# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php
RUN mv ./composer.phar /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer
RUN composer --version
ENV PATH="$PATH:/root/.composer/vendor/bin"

# Install PHP CodeSniffer
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
RUN mv ./phpcs.phar /usr/local/bin/phpcs
RUN chmod a+x /usr/local/bin/phpcs
RUN phpcs --version

# Install Vapor CLI
RUN composer global require laravel/vapor-cli
RUN vapor --version

# Install Node (Includes NPM)
RUN apt-get install nodejs -yqq
RUN node -v
RUN npm -v

# Install Yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="$PATH:/root/.yarn/bin"
RUN yarn -v

# Install Nuxt CLI
RUN yarn global add nuxt @nuxt/typescript-runtime
