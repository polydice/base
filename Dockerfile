FROM polydice/base:0.14.3

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    openssh-client \
    default-libmysqlclient-dev \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libsasl2-dev \
    build-essential \
  && rm -rf /var/lib/apt/lists/*
