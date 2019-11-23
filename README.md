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

## Author Information

Nimrod Adar, [contact me](mailto:nimrod@shore.co.il) or visit my [website](
https://www.shore.co.il/). Patches are welcome via [`git send-email`](
http://git-scm.com/book/en/v2/Git-Commands-Email). The repository is located
at: <https://www.shore.co.il/git/>.
