# frozen_string_literal: true

class VisitedLinksController < ApplicationController
  def index
    params.require(:from)
    params.require(:to)
    domains = get_from_redis(params['from'], params['to'])
    render json: {
        domains: domains,
        status: 'ok'
    }
  rescue StandardError => e
    render json: {status: e}
  end

  def create
    params.require(:links)

    add_to_redis(params['links'])

    render json: {status: 'ok'}
  rescue StandardError => e
    render json: {status: e}
  end

  def get_from_redis(from, to)
    result = REDIS.zrangebyscore('links', from, to)
    result.map do |json|
      data = JSON.parse(json)
      data['domain']
    end.uniq
  end

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
