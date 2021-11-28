rake db:migrate  RAILS_ENV=test 2>/dev/null || rake db:create db:migrate  RAILS_ENV=test
rspec
rake db:migrate RAILS_ENV=development 2>/dev/null || rake db:create db:migrate RAILS_ENV=development
rake elasticsearch:build_index
