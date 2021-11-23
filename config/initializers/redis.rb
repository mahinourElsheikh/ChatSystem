require "redis"
$redis = Redis.new(host: "redis2", port: '6378')
# $redis = Redis.new(host: 'redis2', port: 6378)