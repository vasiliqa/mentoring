FROM ruby:2.5-slim

ENV RAILS_ENV=production \
RACK_ENV=production \
RAILS_SERVE_STATIC_FILES=1 \
RAILS_LOG_TO_STDOUT=1 \
APPDIR=/opt/mentoring

RUN mkdir -p $APPDIR && \
  apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  nodejs \
  postgresql-client-9.6 \
  # required for wait-for script
  netcat

WORKDIR $APPDIR

COPY Gemfile $APPDIR/Gemfile
COPY Gemfile.lock $APPDIR/Gemfile.lock

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle install --without development test

COPY . $APPDIR

# @see: https://github.com/rails/rails/issues/32947
RUN bundle exec rake DATABASE_URL=postgresql:does_not_exist SECRET_KEY_BASE=`bin/rake secret` assets:precompile

EXPOSE 3000
