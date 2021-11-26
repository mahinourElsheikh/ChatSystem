require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe Api::V1::SearchController do
  let!(:my_message) { create(:random_message) }

  describe 'Get a specific message ', type: :request do
    it 'returns the applications' do
      get "/api/v1/applications/#{my_message.chat.application.token}/chats/#{my_message.chat.seq_num}/messages/search",params: { q: 'test' }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message'][0]['_source']).to be_present
    end
  end
end
