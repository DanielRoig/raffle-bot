FROM ruby:3.1.6

RUN apt-get -y update && apt-get -y upgrade

ENV RAFFLE /opt/RAFFLE

RUN mkdir -p $RAFFLE
WORKDIR $RAFFLE

RUN gem install bundler:2.5.18
ADD Gemfile Gemfile.lock $RAFFLE/
RUN bundle install

ADD . $RAFFLE/

ADD start.sh /start
RUN chmod u+x /start

CMD [ "/start"]

#CMD rails s