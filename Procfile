web: bundle exec rails server thin -p $PORT
worker:  QUEUE=* bundle exec rake resque:work
scheduler: bundle exec rake resque:scheduler