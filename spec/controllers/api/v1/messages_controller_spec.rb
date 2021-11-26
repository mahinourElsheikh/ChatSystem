require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe Api::V1::MessagesController do
  let!(:my_chat) { create(:random_chat) }

  describe 'create a message', type: :request do
    before do
      post "/api/v1/applications/#{my_chat.application.token}/chats/#{my_chat.seq_num}/messages",
           params: { message: 'Hello' }
    end
    it "returns the message's data" do
      expect(JSON.parse(response.body)['message']['description']).to eq('Hello')
      expect(JSON.parse(response.body)['message']['seq_num']).to eq(1)
    end
    it 'returns a ok status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'create 3 messages and check seq_num of the messages ', type: :request do
    before do
      3.times do
        post "/api/v1/applications/#{my_chat.application.token}/chats/#{my_chat.seq_num}/messages",
             params: { message: 'Hey' }
      end
    end
    it 'returns a specific message' do
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message']['seq_num']).to eq(3)
    end
  end

  describe 'Get a specific message ', type: :request do
    let!(:my_message) { create(:random_message) }

    it 'returns the applications' do
      get "/api/v1/applications/#{my_message.chat.application.token}/chats/#{my_message.chat.seq_num}/messages/#{my_message.seq_num}"
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['seq_num']).to eq(1)
      expect(JSON.parse(response.body)['description']).to eq('Test Message')
    end
  end
end
