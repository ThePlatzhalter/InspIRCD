FROM debian:jessie

MAINTAINER Platzhalter <platzhalter@sigaint.org>

ADD https://github.com/inspircd/inspircd/archive/v2.0.21.tar.gz /src/

RUN apt-get update && \
        apt-get install -y build-essential libssl-dev libssl1.0.0 openssl pkg-config gnutls-bin gnutls-dev sudo && \
        useradd -u 10000 -d /inspircd inspircd && \
        cd /src && tar -xvf v*.tar.gz && \
        mv `ls -d inspircd-*` inspircd && \
        cd inspircd && \
        ./configure --disable-interactive --enable-gnutls --enable-openssl --enable-epoll --prefix=/inspircd --config-dir=/inspircd/conf --log-dir=/inspircd/logs --data-dir=/inspircd/data --module-dir=/inspircd/modules --binary-dir=/inspircd/bin --uid 10000 && make && make install && \
        apt-get purge -y build-essential

VOLUME ["/inspircd/conf", "/conf"]

EXPOSE 6667 6697

ENTRYPOINT ["sudo", "-u", "inspircd", "/inspircd/bin/inspircd"]
CMD ["--nofork"]
