# Heroku like Docker PHP container

These are docker images for [PHP](https://secure.php.net) running on a [Caddy container](https://registry.hub.docker.com/u/webhippie/caddy/).
This container optimized for fast starting and using with PaaS like as: Heroku, Flynn, Deis Workflow and many others. 
And for many popular PHP frameworks.

## Example for Laravel

```bash
FROM roquie/heroku-like-docker-php:latest

COPY . /srv/www

# Warning! You should be to run chown for files inside a Dockerfile, 
# it needed for fast starting.
RUN chown -R caddy:caddy /srv/www

ENV CADDY_WEBROOT /srv/www/public
```

## Principles

Container should be just fast upped and fast runned, without pre-provisioning. 

* Any dependencies, like as composer, npm/yarn, bower or `%PACKAGE_MANAGER%` should be installed outside of container.
* Any long-operations must be used inside a Dockerfile

## Versions

* latest

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
ENV CONFIGURE_CUSTOM false
```

## Inherited environment variables

* [webhippie/caddy](https://github.com/dockhippie/caddy#available-environment-variables)
* [webhippie/alpine](https://github.com/dockhippie/alpine#available-environment-variables)

## Authors

* [Thomas Boerger](https://github.com/tboerger)
* [Roquie](https://github.com/roquie)

## License

MIT
