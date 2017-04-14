FROM ruby:2.4.0

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y build-essential apt-transport-https cmake python git libpq-dev libxml2-dev libsasl2-dev graphicsmagick yarn libxslt1-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN wget https://bintray.com/byvoid/opencc/download_file?file_path=opencc-1.0.4.tar.gz; tar -xzf download_file\?file_path\=opencc-1.0.4.tar.gz; cd opencc-1.0.4; sed -i "s/DOCUMENTATION\:BOOL\=ON/DOCUMENTATION\:BOOL\=OFF/g" Makefile; make install
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && apt-get install -y nodejs
RUN gem install bundler -v 1.14.3
