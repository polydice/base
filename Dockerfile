ARG RUBY_VERSION=2.7.6
ARG VARIANT=jemalloc-slim
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-${VARIANT} as base

ARG BUNDLER_VERSION=2.3.16
RUN gem install -N bundler -v ${BUNDLER_VERSION}

ARG NODE_VERSION=14.19.3
RUN curl https://get.volta.sh | bash
ENV VOLTA_HOME /root/.volta
ENV PATH $VOLTA_HOME/bin:/usr/local/bin:$PATH
RUN volta install node@${NODE_VERSION} && volta install yarn

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
    libopencc-dev \
  && rm -rf /var/lib/apt/lists/*
