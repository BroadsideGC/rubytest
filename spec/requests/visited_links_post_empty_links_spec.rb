# frozen_string_literal: true

require 'rails_helper'

describe 'post one link', type: :request do
  before do
    endpoint_json = { links: [] }
    post '/visited_links', params: endpoint_json.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'returns ok' do
    expect(JSON.parse(response.body)['status']).to eq('param is missing or the value is empty: links')
  end
end
