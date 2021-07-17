FROM ruby:2.6.4

RUN mkdir -p /root/.ssh

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem update --system && \
    gem install bundler:2.1.4 && \
    bundle install

COPY . .

RUN apt-get update

RUN wget -qO- https://deb.nodesource.com/setup_9.x  | bash - && \
      apt-get install -y nodejs && \
      wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
      apt-get update && \
      apt-get install yarn && \
      apt-get clean
