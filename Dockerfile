FROM ruby:2.5.9

RUN apt-get update
RUN apt-get install -y apt-transport-https

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get -y install \
  build-essential \
  git \
  shared-mime-info \
  tzdata \
  libpq-dev \
  nodejs \
  yarn \
  postgresql-contrib

WORKDIR ./usr/src/app

COPY yarn* ./

RUN yarn install

COPY Gemfile* ./

RUN bundle install

COPY . .

EXPOSE 3000

cmd ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
