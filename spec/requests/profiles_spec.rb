# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/profiles/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/profiles/edit'
      expect(response).to have_http_status(:success)
    end
  end
end
