FROM ruby:3.1-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential git \
      pkg-config \
      libxml2-dev libxslt1-dev zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /site

# Bundler needs the gemspec because Gemfile has `gemspec`
COPY Gemfile Gemfile.lock* ./
COPY *.gemspec ./

RUN bundle install

# Then copy the rest
COPY . .

EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--livereload", "--force_polling"]
