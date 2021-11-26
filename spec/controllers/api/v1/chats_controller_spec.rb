require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe Api::V1::ApplicationsController do
  let!(:my_app) { create(:random_app) }

  describe 'create a chat', type: :request do
    before do
      post "/api/v1/applications/#{my_app.token}/chats",
           params: { message: 'Hey' }
    end
    it "returns the chat's data" do
      expect(JSON.parse(response.body)['chat']['seq_num']).to eq(1)
      expect(JSON.parse(response.body)['chat']['messages_count']).to eq(1)
    end
    it 'returns a ok status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'create 3 chats and check seq_num of the third ', type: :request do
    before do
      3.times do
        post "/api/v1/applications/#{my_app.token}/chats",
             params: { message: 'Hey' }
      end
    end
    it 'returns a specific chat' do
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['chat']['seq_num']).to eq(3)
    end
  end

  describe 'Get a specific chat ', type: :request do
    let!(:my_chat) { create(:random_chat) }

    it 'returns the applications' do
      get "/api/v1/applications/#{my_chat.application.token}/chats/#{my_chat.seq_num}/"
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)[0]['seq_num']).to eq(1)
    end
  end
end
