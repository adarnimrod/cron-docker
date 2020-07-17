FROM alpine:3.12 as downloader
ARG URL=https://github.com/aptible/supercronic/releases/download/v0.1.9/supercronic-linux-amd64
ARG SHA1SUM=5ddf8ea26b56d4a7ff6faecdd8966610d5cb9d85
WORKDIR /tmp
RUN wget $URL && \
    echo "$SHA1SUM  supercronic-linux-amd64" > sha1.sum && \
    sha1sum -c sha1.sum && \
    install -m 755 supercronic-linux-amd64 /usr/local/bin/supersonic && \
    touch /crontab

FROM alpine:3.12
COPY --from=downloader /usr/local/bin/supersonic /usr/local/bin/supersonic
COPY --from=downloader /crontab /crontab
WORKDIR /tmp
USER nobody
CMD [ "supersonic", "/crontab" ]
HEALTHCHECK CMD pgrep supersonic
RUN supersonic -test /crontab
ONBUILD RUN supersonic -test /crontab
