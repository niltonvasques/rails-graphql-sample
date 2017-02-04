#!/bin/bash

sed -e 's/${HOST_URL}/'"$HOST_URL"'/' /etc/nginx/sites-enabled/ticket-system.conf > /etc/nginx/sites-enabled/ticket-system.new
mv /etc/nginx/sites-enabled/ticket-system.new /etc/nginx/sites-enabled/ticket-system.conf
cd /home/app/ticket-system/
while ! exec 6<>/dev/tcp/db/3306; do 
  echo 'still trying to connect to mysql at db:3306'; 
  sleep 1; 
done; 
if [ $RAILS_ENV = "test" ]; then
  bundle exec rake db:drop;
fi
bundle exec rake db:create; 
bundle exec rake db:migrate; 
if [ $RAILS_ENV = "test" ]; then
  bundle exec rake db:seed;
fi
#if [ $RAILS_ENV = "production" ]; then
#fi
chown -R app:app .
