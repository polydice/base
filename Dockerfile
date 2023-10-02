FROM polydice/base:0.31.0

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    openssh-client \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libsasl2-dev \
    libmcrypt-dev \
    build-essential \
  && rm -rf /var/lib/apt/lists/*
