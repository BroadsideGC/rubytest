REDIS = # frozen_string_literal: true

  if Rails.env.test?
    Redis::Namespace.new(:my_namespace, redis: MockRedis.new)
  else
    Redis::Namespace.new('test_app', redis: Redis.new)

  end
