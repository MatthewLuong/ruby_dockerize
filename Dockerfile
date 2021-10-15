FROM ruby:3.0.2

# install required libraries
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  build-essential \
  nodejs \
  yarn && \
  apt-get clean && \
  rm --recursive --force /var/lib/apt/lists/*

#Working directory
RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install
ADD . /app
