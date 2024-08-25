FROM ruby:3.1.2

RUN apt-get -y update && apt-get -y upgrade

ENV RAILS_API_BOILERPLATE /opt/RAILS_API_BOILERPLATE

RUN mkdir -p $RAILS_API_BOILERPLATE
WORKDIR $RAILS_API_BOILERPLATE

RUN gem install bundler:2.3.14
ADD Gemfile Gemfile.lock $RAILS_API_BOILERPLATE/
RUN bundle install

ADD . $RAILS_API_BOILERPLATE/

ADD start.sh /start
RUN chmod u+x /start

CMD [ "/start" ]

#CMD rails s