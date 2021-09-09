FROM ubuntu:rolling

RUN apt-get update \
    && apt-get install -y \
    bash \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
