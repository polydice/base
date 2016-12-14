FROM ruby:2.3.3

RUN apt-get update && apt-get install -y build-essential cmake python doxygen git libpq-dev libxml2-dev graphicsmagick libxslt1-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN wget https://bintray.com/byvoid/opencc/download_file?file_path=opencc-1.0.4.tar.gz; tar -xzf download_file\?file_path\=opencc-1.0.4.tar.gz; cd opencc-1.0.4; make install
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && apt-get install -y nodejs
RUN npm install -g yarn
