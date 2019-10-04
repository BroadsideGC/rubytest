# frozen_string_literal: true

require 'rails_helper'
require 'helper'

RSpec.configure do |c|
  c.include Helpers
end

describe 'get one link', type: :request do
  before do
    links = ['ya.ru']
    add_to_redis(links)
    get '/visited_links', from: 0, to: Time.now.to_i
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns ok' do
    expect(JSON.parse(response.body)['status']).to eq('ok')
  end

  it 'returns ya.ru' do
    expect(JSON.parse(response.body)['domains']).to eq(['ya.ru'])
  end
end
