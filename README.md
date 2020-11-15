# alpine-java-wkhtmltopdf

[![Run Status](https://api.shippable.com/projects/5a1c82451e6eda070008cbbb/badge?branch=master)](https://app.shippable.com/github/ElfoLiNk/alpine-java-wkhtmltopdf)
[![Docker Stars](https://img.shields.io/docker/stars/elfolink/alpine-java-wkhtmltopdf.svg)](https://hub.docker.com/r/elfolink/alpine-java-wkhtmltopdf/)
[![Docker Pulls](https://img.shields.io/docker/pulls/elfolink/alpine-java-wkhtmltopdf.svg)](https://hub.docker.com/r/elfolink/alpine-java-wkhtmltopdf/)

This Docker image contains a working wkhtmltopdf and java installation. The purpose is to keep it as small as possible while delivering all functions.

## Use as baseimage

This image can be used as a base for your project.

```yaml
FROM elfolink/alpine-java-wkhtmltopdf
```

## Tag Versions

| Tag             | 3.8        |
| :---            | :---:      |
| Alpine          | 3.8         |
| Java            | 1.8.222.10  |
| Wkhtmltopdf     | 0.12.7.dev  |

## Contribute

Please feel free to open a issue or pull request with suggestions.

Keep in mind that the build process of this container takes some (a lot of) time.

## Credits

Based upon the following repos:
- https://github.com/Surnet/alpine-node-wkhtmltopdf
- https://github.com/alloylab/Docker-Alpine-wkhtmltopdf
