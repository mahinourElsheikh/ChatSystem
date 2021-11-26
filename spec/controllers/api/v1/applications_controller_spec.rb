require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe Api::V1::ApplicationsController do
  describe 'create an application', type: :request do
    before do
      post '/api/v1/applications',
           params: { application: { name: 'App1' } }
    end
    it "returns the application's name" do
      expect(JSON.parse(response.body)['name']).to eq('App1')
    end
    it "returns the application's token" do
      expect(JSON.parse(response.body)['token']).to be_present
    end
    it 'returns a ok status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'multiple application CRUD', type: :request do
    let!(:my_app) { create(:random_app) }

    it 'returns the applications' do
      get '/api/v1/applications'
      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)['count']).to eq(1)
    end

    it 'returns the 2nd applications seq_num' do
      create(:random_app)
      get '/api/v1/applications'
      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)['count']).to eq(2)
    end

    it 'gets  a specific application' do
      get "/api/v1/applications/#{my_app.token}"
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['token']).to eq(my_app.token)
      expect(JSON.parse(response.body)['chats_count']).to eq(0)
    end

    it 'updates an application' do
      put "/api/v1/applications/#{my_app.token}", params: { application: { name: 'App2' } }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['name']).to eq('App2')
      expect(JSON.parse(response.body)['token']).to eq(my_app.token)
    end
  end
end
