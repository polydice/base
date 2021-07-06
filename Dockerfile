FROM polydice/jemalloc_ruby:2.7.3-node-14-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    dumb-init \
    mysql-client \
    default-libmysqlclient-dev \
    postgresql-client \
    graphicsmagick \
    file \
    tar \
    curl \
    ca-certificates \
    libmcrypt4 \
    shared-mime-info \
  && rm -rf /var/lib/apt/lists/*
