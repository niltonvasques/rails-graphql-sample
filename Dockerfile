FROM phusion/passenger-ruby23:0.9.19
MAINTAINER Nilton Vasques "nilton.vasques@gmail.com" 

ENV HOME /root
ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y libmysqlclient-dev imagemagick zlib1g-dev vim  cmake pkg-config --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD docker/40_presetup_app.sh /etc/my_init.d/40_presetup_app.sh
ADD docker/prod.conf /etc/nginx/sites-enabled/ticket-system.conf
ADD docker/env.conf /etc/nginx/main.d/env.conf
RUN mkdir /etc/nginx/ssl
ADD docker/input.openssl /etc/nginx/ssl/input.openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt < /etc/nginx/ssl/input.openssl

# APP SETTINGS
RUN bundle config --global frozen 1
# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock

ENV RAILS_ENV production

RUN mkdir /home/app/ticket-system
ADD . /home/app/ticket-system
WORKDIR /home/app/ticket-system

RUN bundle install --deployment --verbose --retry 4 --jobs 5
RUN ls -la
RUN ls -la vendor/
RUN pwd

RUN chown -R app:app /home/app/ticket-system
RUN ls -la vendor
RUN pwd

RUN chown -R app:app /home/app/ticket-system

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#----------------------------------------------------------------------
