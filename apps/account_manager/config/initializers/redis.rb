require 'redis'
db = 0
db = 1 if Rails.env.test?
$redis = Redis.new(url: "#{ENV.fetch('REDIS_URL')}", db: db)
