FROM ruby:2.6.5-slim

ENV APP_DIR=/app

ARG RAILS_MASTER_KEY

RUN set -x \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        curl \
    && rm -rf /var/apt/lists/*

RUN set -x \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        gnupg \
    && rm -rf /var/apt/lists/*

RUN set -x \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libxml2 \
        libxml2-dev \
        libxslt-dev \
        zlib1g-dev \
        gcc \
        g++ \
        make \
        git \
        default-libmysqlclient-dev \
    && rm -rf /var/apt/lists/*

RUN set -x \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y --no-install-recommends \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN set -x \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        yarn \
    && rm -rf /var/lib/apt/lists/*

RUN gem update --system 2.7.6 && gem install bundler -v 2.1.2

WORKDIR $APP_DIR

COPY Gemfile $APP_DIR
COPY Gemfile.lock $APP_DIR

RUN bundle install -j4 --without development

COPY . $APP_DIR

RUN RAILS_ENV=production bin/rails assets:precompile

CMD ["bin/rails", "s", "-b", "0.0.0.0", "-p", "3000"]
