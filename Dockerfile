FROM alpine:3.13 as downloader
ARG URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64
ARG SHA1SUM=048b95b48b708983effb2e5c935a1ef8483d9e3e
WORKDIR /tmp
RUN wget $URL && \
    echo "$SHA1SUM  supercronic-linux-amd64" > sha1.sum && \
    sha1sum -c sha1.sum && \
    install -m 755 supercronic-linux-amd64 /usr/local/bin/supersonic && \
    touch /crontab

FROM alpine:3.13
COPY --from=downloader /usr/local/bin/supersonic /usr/local/bin/supersonic
COPY --from=downloader /crontab /crontab
WORKDIR /tmp
USER nobody
CMD [ "supersonic", "/crontab" ]
HEALTHCHECK CMD pgrep supersonic
RUN supersonic -test /crontab
ONBUILD COPY crontab /crontab
ONBUILD RUN supersonic -test /crontab
