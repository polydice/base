ARG RUBY_VERSION=2.7.8
FROM ruby:${RUBY_VERSION}-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# jemalloc for better memory management
RUN apt-get update && apt-get install -y --no-install-recommends libjemalloc2 \
  && JEMALLOC_PATH=$(find /usr/lib -name "libjemalloc.so.2" | head -1) \
  && [ -n "$JEMALLOC_PATH" ] || (echo "libjemalloc.so.2 not found" && exit 1) \
  && ln -sf "$JEMALLOC_PATH" /usr/lib/libjemalloc.so.2 \
  && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD=/usr/lib/libjemalloc.so.2

# Install build tools and native extension dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    libffi-dev \
  && rm -rf /var/lib/apt/lists/*

ARG BUNDLER_VERSION=2.4.22
RUN gem install -N bundler -v ${BUNDLER_VERSION}

ARG NODE_VERSION=18.18.0
ARG YARN_VERSION=1.22.22
ARG PNPM_VERSION=9.9.0
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
  && rm -rf /var/lib/apt/lists/* \
  && curl -fsSL https://get.volta.sh | bash
ENV VOLTA_HOME=/root/.volta
ENV VOLTA_FEATURE_PNPM=1
ENV PATH=$VOLTA_HOME/bin:/usr/local/bin:$PATH
RUN volta install node@${NODE_VERSION} && volta install yarn@${YARN_VERSION} && volta install pnpm@${PNPM_VERSION}

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    dumb-init \
    default-mysql-client \
    default-libmysqlclient-dev \
    postgresql-client \
    graphicsmagick \
    file \
    tar \
    shared-mime-info \
    libmcrypt4 \
  && rm -rf /var/lib/apt/lists/*

# Don't add g++/make to buildDeps, or purge will remove build-essential
WORKDIR /tmp
RUN set -ex \
  && buildDeps='cmake python3' \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && rm -rf /var/lib/apt/lists/* \
  && curl -L https://github.com/BYVoid/OpenCC/archive/refs/tags/ver.1.1.9.tar.gz | tar -xz

WORKDIR /tmp/OpenCC-ver.1.1.9
RUN REL_BUILD_DOCUMENTATION=OFF make install

WORKDIR /tmp
RUN apt-get purge -y --auto-remove cmake python3 \
  && rm -rf OpenCC-ver.1.1.9

WORKDIR /app
