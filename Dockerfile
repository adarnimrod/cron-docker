FROM alpine:3.9 as downloader
ARG URL=https://github.com/aptible/supercronic/releases/download/v0.1.8/supercronic-linux-amd64
ARG SHA1SUM=be43e64c45acd6ec4fce5831e03759c89676a0ea
RUN cd /tmp && \
    wget $URL && \
    echo "$SHA1SUM  supercronic-linux-amd64" > sha1.sum && \
    sha1sum -c sha1.sum && \
    install -m 755 supercronic-linux-amd64 /usr/local/bin/supersonic && \
    touch /crontab

FROM alpine:3.9
COPY --from=downloader /usr/local/bin/supersonic /usr/local/bin/supersonic
COPY --from=downloader /crontab /crontab
WORKDIR /tmp
USER nobody
CMD [ "supersonic", "/crontab" ]
HEALTHCHECK CMD pgrep supersonic
RUN supersonic -test /crontab
