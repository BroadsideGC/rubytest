# frozen_string_literal: true

require 'rails_helper'

describe 'get with empty links', type: :request do
  before do
    get '/visited_links', params: { from: 0, to: Time.now.to_i }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns not ok' do
    expect(JSON.parse(response.body)['status']).to eq('ok')
  end

  it 'returns correct error' do
    expect(JSON.parse(response.body)['domains']).to eq([])
  end
end
