#!/bin/bash
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate
exec "$@"
