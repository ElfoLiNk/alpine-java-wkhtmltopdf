# alpine-java-wkhtmltopdf

[![Run Status](https://github.com/ElfoLiNk/alpine-java-wkhtmltopdf/workflows/ci/badge.svg?branch=master)
[![Docker Stars](https://img.shields.io/docker/stars/elfolink/alpine-java-wkhtmltopdf.svg)](https://hub.docker.com/r/elfolink/alpine-java-wkhtmltopdf/)
[![Docker Pulls](https://img.shields.io/docker/pulls/elfolink/alpine-java-wkhtmltopdf.svg)](https://hub.docker.com/r/elfolink/alpine-java-wkhtmltopdf/)

This Docker image contains a working wkhtmltopdf and java installation. The purpose is to keep it as small as possible while delivering all functions.

## Use as baseimage

This image can be used as a base for your project.

```yaml
FROM elfolink/alpine-java-wkhtmltopdf
```

## Tag Versions

| Tag             | latest        | 3.12        | 3.11        | 3.10        | 3.9        | 3.8        | 3.7        | 3.6        |
| :---            | :---:         | :---:       | :---:       | :---:       | :---:      | :---:      | :---:      | :---:      |
| Alpine          | edge          | 3.12        | 3.11        | 3.10        | 3.9        | 3.8        | 3.7        | 3.6        |
| Java            | 1.8.272.10    | 1.8.252.09  | 1.8.252.09  | 1.8.252.09  | 1.8.252.09 | 1.8.222.10 | 1.8.222.10 | 1.8.151.12 |
| Wkhtmltopdf     | 0.12.7.dev    | 0.12.7.dev  | 0.12.7.dev  | 0.12.7.dev  | 0.12.7.dev | 0.12.7.dev | 0.12.7.dev | 0.12.5.dev |

## Contribute

Please feel free to open a issue or pull request with suggestions.

Keep in mind that the build process of this container takes some (a lot of) time.

## Credits

Based upon the following repos:
- https://github.com/Surnet/alpine-node-wkhtmltopdf
- https://github.com/alloylab/Docker-Alpine-wkhtmltopdf

