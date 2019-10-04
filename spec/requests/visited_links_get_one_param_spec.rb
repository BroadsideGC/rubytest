# frozen_string_literal: true

require 'rails_helper'

describe 'get with one param', type: :request do
  before do
    get '/visited_links', params: { from: 0 }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns not ok' do
    expect(JSON.parse(response.body)['status']).not_to eq('ok')
  end

  it 'returns correct error' do
    expect(JSON.parse(response.body)['status']).to eq('param is missing or the value is empty: to')
  end
end
