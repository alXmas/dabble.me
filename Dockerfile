FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client ca-certificates rsync vim graphviz redis-tools
RUN mkdir /app

# Uncomment this line if you want to run binstubs without prefixing with `bin/` or `bundle exec`
ENV PATH /app/bin:$PATH

RUN gem update --system && \
    gem install bundler:2.0.2
    
WORKDIR /app
