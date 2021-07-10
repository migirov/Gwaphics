FROM ruby:2.5.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle config --global disable_platform_warnings 1

ENV BUNDLER_VERSION=2.1.4

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock package.json package-lock.json ./

RUN apt-get update \
    && apt-get -y install curl gnupg \
    && curl -sL https://deb.nodesource.com/setup_14.x  | bash - \
    && apt-get -y install nodejs \
    && npm i

RUN gem update --system \
    && gem install bundler:$BUNDLER_VERSION \
    && bundle install

# TODO: RUN bin/rails
# TODO: RUN npm run postinstall

COPY . .
