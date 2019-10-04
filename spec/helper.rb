module Helpers
  def add_to_redis(links)
    now_ts = Time.now.to_i
    links.each do |link|
      link = 'http://' + link unless link.match(/^http(s)?:\/\//)
      obj = {
          domain: URI.parse(link).host,
          timestamp: now_ts
      }
      REDIS.zadd('links', now_ts, obj.to_json)
    end
  end
end