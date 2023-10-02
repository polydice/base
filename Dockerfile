ARG RUBY_VERSION=2.7.7
ARG VARIANT=jemalloc-slim
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-${VARIANT} as base

ARG BUNDLER_VERSION=2.4.5
RUN gem install -N bundler -v ${BUNDLER_VERSION}

ARG NODE_VERSION=18.18.0
ARG YARN_VERSION=1.22.19
ARG PNPM_VERSION=8.8.0
RUN curl https://get.volta.sh | bash
ENV VOLTA_HOME /root/.volta
ENV VOLTA_FEATURE_PNPM=1
ENV PATH $VOLTA_HOME/bin:/usr/local/bin:$PATH
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
    curl \
    ca-certificates \
    libmcrypt4 \
    shared-mime-info \
  && rm -rf /var/lib/apt/lists/*

RUN set -ex \
  \
  && buildDeps=' \
    g++ \
    make \
    cmake \
    python \
  ' \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && rm -rf /var/lib/apt/lists/* \
  \
  && curl -L https://github.com/BYVoid/OpenCC/archive/refs/tags/ver.1.1.6.tar.gz | tar -xz \
  && cd OpenCC-ver.1.1.6 \ 
  && sed -i "s/DOCUMENTATION\:BOOL\=ON/DOCUMENTATION\:BOOL\=OFF/g" Makefile \
  && make install \
  \
  && apt-get purge -y --auto-remove $buildDeps \
  && cd ../ \
  && rm -rf OpenCC-ver.1.1.6
