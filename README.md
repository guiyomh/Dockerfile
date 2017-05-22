Guiyomh Dockerfile
==================

[![](https://travis-ci.org/Guiyomh/Dockerfile.svg?branch=master)](https://travis-ci.org/Guiyomh/Dockerfile "Show travis CI")

The Dockerfile repository is reponsible for generating our Docker images on https://hub.docker.com/u/guiyomh/.

We generate tested Docker images. That can be used as a basis for starting a project.

All Docker images are generated and tested by [Travis CI](https://travis-ci.org/Infogene/Dockerfile).

| Image  | description                                    | Badge |
|:------:|:-----------------------------------------------|:-----:|
| Base   | A basic image to gather the common tools       | [![badge-base]](https://microbadger.com/images/infogene/base "Layers of infogene/base")|
| Php    | A php-fpm tools with popular extension         |  [![badge-php]](https://microbadger.com/images/infogene/php "Layers of infogene/php") |
| Composer | Extends composer Image with hirak/prestissimo  |  [![badge-composer]](https://microbadger.com/images/infogene/composer "Layers of infogene/composer") |

Building
========
| Command          | Description                             |
|:-----------------|:----------------------------------------|
| `make all`       | Build all the images                    |
| `make php`       | Build the php images                    |
| `make composer`  | Build the composer images               |

[badge-base]: https://images.microbadger.com/badges/image/guiyomh/base.svg
[badge-php]: https://images.microbadger.com/badges/image/guiyomh/php.svg
[badge-php-oci]: https://images.microbadger.com/badges/image/guiyomh/php:7.1-oci.svg
[badge-composer]: https://images.microbadger.com/badges/image/guiyomh/composer.svg
