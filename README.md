Guiyomh Dockerfile
==================
[![](https://travis-ci.org/guiyomh/Dockerfile.svg?branch=master)](https://travis-ci.org/guiyomh/Dockerfile "Show travis CI")
[![](https://travis-ci.org/guiyomh/Dockerfile.svg?branch=master)](https://travis-ci.org/guiyomh/Dockerfile "Show travis CI")

The Dockerfile repository is reponsible for generating our Docker images on https://hub.docker.com/u/guiyomh/.

We generate tested Docker images. That can be used as a basis for starting a project.

All Docker images are generated and tested by [Travis CI](https://travis-ci.org/Infogene/Dockerfile).

| Image  | description                                    | Badge |
|:------:|:-----------------------------------------------|:-----:|
| Php    | A php-fpm tools with popular extension         |  [![badge-php]](https://microbadger.com/images/guiyomh/php "Layers of guiyomh/php") |
| Composer | Extends composer Image with hirak/prestissimo  |  [![badge-composer]](https://microbadger.com/images/guiyomh/composer "Layers of guiyomh/composer") |
| Immortal | A *nix cross-platform (OS agnostic) supervisor  |  [![badge-immortal]](https://microbadger.com/images/guiyomh/immortal "Layers of guiyomh/immortal") |

Building
========
| Command          | Description                             |
|:-----------------|:----------------------------------------|
| `make all`       | Build all the images                    |
| `make php`       | Build the php images                    |
| `make composer`  | Build the composer images               |
| `make immortal`  | Build the immortal images               |

[badge-php]: https://images.microbadger.com/badges/image/guiyomh/php.svg
[badge-composer]: https://images.microbadger.com/badges/image/guiyomh/composer.svg
[badge-immortal]: https://images.microbadger.com/badges/image/guiyomh/immortal.svg
