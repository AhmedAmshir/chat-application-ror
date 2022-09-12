rm -f tmp/pids/server.pid
bundle install
rake db:migrate
rake elastic_launch
bundle exec whenever