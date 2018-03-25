# Heroku like Docker PHP container

These are docker images for [PHP](https://secure.php.net) running on a [Nginx container](https://registry.hub.docker.com/u/webhippie/nginx/).
This container optimized for fast starting and using with PaaS like as: Heroku, Flynn, Deis Workflow and many others. 
And for many popular PHP frameworks.

## PHP-FPM

By default this container to disable clear_env option of php-fpm inside a 
config for pools. This needed for reading environment variables passed 
by PasS service (like as [flynn](https://flynn.io)) before starting the `php-fpm` process.
<br>
So, if you're want to return behavior to default settings, you can be set up that env variable.
<br><br>
For example like this: <br>
```bash
ENV PHP_FPM_CLEAR_ENV yes
```

## Example for Laravel

```bash
FROM roquie/heroku-like-docker-php:latest

COPY --chown=nginx:nginx . /srv/www

ENV NGINX_WEBROOT /srv/www/public
```

## Example enabling cronjob for Laravel tasks

```bash
FROM roquie/heroku-like-docker-php:latest

COPY --chown=nginx:nginx . /srv/www

ENV CRON_ENABLED true
RUN echo -e "* * * * * php /srv/www/artisan schedule:run >> /dev/null 2>&1\nMAILTO=email@example.com" >> /etc/crontabs/root
```

## Principles

Container should be just fast upped and fast runned, without pre-provisioning. 

* Any dependencies, like as composer, npm/yarn, bower or `%PACKAGE_MANAGER%` should be installed outside of container.
* Any long-operations must be used inside a Dockerfile

## Upgrade from previous version

* Change `CADDY_WEBROOT` env variable to `NGINX_WEBROOT`.
* Use `RUN chown -R nginx:nginx /srv/www`.
* Done.

## Volumes

* /srv/www
* /etc/php7/custom.d

## Ports

* 8080

## Available environment variables

```bash
ENV PHP_MEMORY_LIMIT 512M
ENV PHP_POST_MAX_SIZE 2G
ENV PHP_UPLOAD_MAX_FILESIZE 2G
ENV PHP_MAX_EXECUTION_TIME 3600
ENV PHP_MAX_INPUT_TIME 3600
ENV PHP_DATE_TIMEZONE UTC
ENV PHP_LOG_LEVEL warning
ENV PHP_MAX_CHILDREN 75
ENV PHP_MAX_REQUESTS 500
ENV PHP_PROCESS_IDLE_TIMEOUT 10s
ENV PHP_FPM_CLEAR_ENV no
ENV PHP_INI_EXPOSE Off
ENV CONFIGURE_CUSTOM false
ENV CRON_ENABLED false
ENV PHP_RUN_USER nginx
ENV PHP_RUN_GROUP nginx
```

## Inherited environment variables

* [webhippie/nginx](https://github.com/dockhippie/nginx#available-environment-variables)
* [webhippie/alpine](https://github.com/dockhippie/alpine#available-environment-variables)

## How to works with MongoDB?

You can be built extension from source:

```
FROM roquie/heroku-like-docker-php:latest

ENV PHP_EXT_BUILD_DEPS \
    autoconf \
    dpkg-dev dpkg \
    file \
    g++ \
    gcc \
    libc-dev \
    make \
    pcre-dev \
    pkgconf \
    re2c \
    php7-dev \
    coreutils \
    curl-dev \
    libedit-dev \
    libxml2-dev \
    openssl-dev

RUN apk add --no-cache $PHP_EXT_BUILD_DEPS && \
    pecl install mongodb && \
    echo "extension=mongodb.so" > /etc/php7/conf.d/03_mongodb.ini && \
    chmod 755 /usr/lib/php7/modules/mongodb.so && \
    pecl clear-cache
    # apk del $PHP_EXT_BUILD_DEPS

ENV NGINX_WEBROOT /srv/www/public
```

## Versions

* latest

## Authors

* [Thomas Boerger](https://github.com/tboerger)
* [Roquie](https://github.com/roquie)

## License

MIT
