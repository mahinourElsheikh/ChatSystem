rake db:migrate 2>/dev/null || rake db:create db:migrate
rspec
rake elasticsearch:build_index
