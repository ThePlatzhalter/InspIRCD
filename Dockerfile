FROM debian:jessie

MAINTAINER Platzhalter <platzhalter@sigaint.org>

ADD https://github.com/inspircd/inspircd/archive/v2.0.21.tar.gz /src/

RUN apt-get update
RUN apt-get install -y build-essential libssl-dev libssl1.0.0 openssl pkg-config gnutls-bin gnutls-dev sudo
RUN useradd -u 10000 -d /inspircd inspircd
WORKDIR /src
RUN tar -xvf v*.tar.gz
RUN mv `ls -d inspircd-*/` inspircd
WORKDIR inspircd
RUN ./configure --disable-interactive --enable-gnutls --enable-openssl --enable-epoll --prefix=/inspircd --config-dir=/inspircd/conf --log-dir=/inspircd/logs --data-dir=/inspircd/data --module-dir=/inspircd/modules --binary-dir=/inspircd/bin --uid 10000
RUN  make
RUN make install
RUN apt-get purge -y build-essential
RUN rm -rf /src

VOLUME ["/inspircd/conf", "/conf"]

EXPOSE 6667 6697

ENTRYPOINT ["sudo", "-u", "inspircd", "/inspircd/bin/inspircd"]
CMD ["--nofork"]
