require 'rails_helper'

RSpec.describe 'Items', type: :request do
  describe 'get /items' do
    before do
      get "/item/#{item.token}"
      # follow 3 redirects to auth and come back
      3.times { follow_redirect! }
    end

    context 'It redirects to the end_service URI with the proper params' do
      let (:item) { FactoryGirl.create(:item) }
      let (:end_service) { item.end_service }

      it { expect(response).to have_http_status(:redirect) }
      it do
        uri = URI(end_service.uri)
        uri.query = {item_token: item.token, session_token: session[:session]['token']}.to_query
        expect(response).to redirect_to(uri.to_s)
      end
    end

    context 'It interpolates strings if it can' do
      let (:end_service) { FactoryGirl.create(:end_service, uri: 'https://example.com/:session_token/:item_token') }
      let (:item) { FactoryGirl.create(:item, end_service: end_service) }

      it do
        expect(response).to redirect_to("https://example.com/#{session[:session]['token']}/#{item.token}")
      end
    end
  end
end
