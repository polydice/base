FROM polydice/base:0.14.2

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    default-libmysqlclient-dev \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libsasl2-dev \
    build-essential \
  && rm -rf /var/lib/apt/lists/*
