# Cron docker

A Docker image for running a Cron daemon, actually running
[Supersonic](https://github.com/aptible/supercronic).

## Usage

There are possible usage patterns for this image. The first is using it in a
multi-stage image build as the source of the `supersonic` binary to incorporate
in your own image like so:

```
FROM adarnimrod/cron as supersonic

FROM alpine:latest
COPY --from=supersonic /usr/local/bin/supersonic /usr/local/bin/
```

The other pattern is building on top of this image to run some periodic tasks
like so:

```
FROM adarnimrod/cron
RUN apk add --update --no-cache aws-cli
COPY crontab /crontab
COPY script /usr/local/bin/
```

## License

This software is licensed under the MIT license (see `LICENSE.txt`).
