require 'rails_helper'

RSpec.describe 'Warden', type: :request do
  before { ENV['MVPAAS_SECRET'] = pem.to_s }
  after  { ENV['MVPAAS_SECRET'] = nil }

  describe "GET #index" do
    let(:pem) { generate_pem }
    let(:token) { generate_jwt(pem) }
    let(:redirect_url) { "#{ENV['MVPAAS_URL']}/sign_in.html" }

    context 'with a valid token' do
      it "logs the user in" do
        get '/dashboard', params: { token: token }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an empty token' do
      it "redirects to the MVP sign in page" do
        get '/dashboard', params: { token: nil }
        expect(response).to redirect_to(redirect_url)
      end
    end

    context 'with an invalid token' do
      it "redirects to the MVP sign in page" do
        get '/dashboard', params: { token: 'xxx' }
        expect(response).to redirect_to(redirect_url)
      end
    end
  end
end
