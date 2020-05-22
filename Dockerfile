FROM atitan/jemalloc_ruby:2.6.6-node-12-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    dumb-init \
    git \
    mysql-client \
    default-libmysqlclient-dev \
    postgresql-client \
    graphicsmagick \
    libcurl3 \
    openssh-client \
    sshpass \
    file \
    wget \
    tar \
    curl \
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
  && wget -qO- https://s3-ap-northeast-1.amazonaws.com/devops.polydice.com/opencc-1.0.4.tar.gz | tar -xvz \
  && cd opencc-1.0.4 \ 
  && sed -i "s/DOCUMENTATION\:BOOL\=ON/DOCUMENTATION\:BOOL\=OFF/g" Makefile \
  && make install \
  \
  && apt-get purge -y --auto-remove $buildDeps \
  && cd ../ \
  && rm -rf opencc-1.0.4*
