# platzhalter/inspircd Dockerfile

This repository contains the Dockerfile of [InspIRCd](http://www.inspircd.org/) for running an own InspIRCD server in a docker container.

## Base Image

I based my image on the [Debian 8 Jessie](https://registry.hub.docker.com/_/debian/) image.

## Usage

1. Create a folder containing all your configuration files used by [InspIRCD](http://www.inspircd.org). It has to contain at least the `inspircd.conf`-file, but you are free to use multiple configuration files and `<include file="/inspircd/conf/yourfile.conf">`-tags. Just make sure you're using absolute filepaths to make sure InspIRCD will **always** be able to parse your configs.
2. Run it doing: `docker run -p 6667:6667 -p 6697:6697 -v /path/to/your/configuration/directory:/inspircd/conf -d platzhalter/inspircd

## Notes

- I compiled *m_ssl_gnutls.so* as well as *m_ssl_openssl.so* into this image so you will be able to use both GnuTLS and OpenSSL
- Also, I made a `/conf`-volume. This is very useful if you run multiple servers linked with each other and you want to have global configs (like the same operators on each server, etc.)