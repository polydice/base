FROM atitan/jemalloc_ruby:2.5.3-node-10-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    dumb-init \
    git \
    mysql-client \
    default-libmysqlclient-dev \
    postgresql-client \
    graphicsmagick \
    libcurl3 \
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
  && wget -qO- https://bintray.com/byvoid/opencc/download_file?file_path=opencc-1.0.4.tar.gz | tar -xvz \
  && cd opencc-1.0.4 \ 
  && sed -i "s/DOCUMENTATION\:BOOL\=ON/DOCUMENTATION\:BOOL\=OFF/g" Makefile \
  && make install \
  \
  && apt-get purge -y --auto-remove $buildDeps \
  && cd ../ \
  && rm -rf opencc-1.0.4*
