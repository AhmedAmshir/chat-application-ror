FROM ruby:2.4.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /app

WORKDIR /app 

ADD Gemfile /app/Gemfile

ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

RUN apt-get update && apt-get install -y cron

ADD . /app