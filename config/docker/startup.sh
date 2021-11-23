# startup.sh#! /bin/sh

# Wait for DB services
# sh ./config/docker/wait-for-services.sh

# Prepare DB (Migrate - If not? Create db & Migrate)
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate

# Pre-comple app assets
# Start Application
# bundle exec rake assets:precompile
# bundle exec puma -C config/puma.rb
# bundle exec redis-server

