# frozen_string_literal: true

require 'rails_helper'
require 'helper'

RSpec.configure do |c|
  c.include Helpers
end

describe 'get multiply link', type: :request do
  before do
    links = ['https://ya.ru', 'https://ya.ru?q=123', 'funbox.ru', 'https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor']
    add_to_redis(links)
    get '/visited_links',params:{ from: 0, to: Time.now.to_i}
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns ok' do
    expect(JSON.parse(response.body)['status']).to eq('ok')
  end

  it 'returns multiple lines' do
    expect(JSON.parse(response.body)['domains']).to match_array(["ya.ru","funbox.ru","stackoverflow.com"])
  end
end
