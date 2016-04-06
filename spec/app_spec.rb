require 'spec_helper'

describe StravaTFL::API do

  def app
    StravaTFL::API
  end

  context 'GET /healthcheck' do
    it 'returns status => ok' do
      get '/healthcheck'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({"status" => "ok"})
    end
  end

  context 'GET /auth/token' do
    context "when invalid token flow" do
      it 'returns access_token' do
        get '/auth/token', {}, {'rack.session'=>{:access_token => '123123'}}
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq({"access_token"=>"123123"})
      end
    end

    context "when invalid token flow" do
      it '/auth/token returns "error_message"=>"Invalid access token."' do
        get '/auth/token'
        expect(last_response.status).to eq(401)
        expect(JSON.parse(last_response.body)).to eq({"error_message"=>"Invalid access token."})
      end

      it 'api/v1/athlete returns "error_message"=>"Invalid access token."' do
        get 'api/v1/athlete'
        expect(last_response.status).to eq(401)
        expect(JSON.parse(last_response.body)).to eq({"error_message"=>"Invalid access token."})
      end

      it 'api/v1/activities returns "error_message"=>"Invalid access token."' do
        get 'api/v1/activities'
        expect(last_response.status).to eq(401)
        expect(JSON.parse(last_response.body)).to eq({"error_message"=>"Invalid access token."})
      end

    end
  end
end
