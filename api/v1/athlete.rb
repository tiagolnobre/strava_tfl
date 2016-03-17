class Athlete < Grape::API
  format :json

  helpers do
    def access_token
      env['rack.session'][:access_token]
    end

    def client
      @client ||= Strava::Api::V3::Client.new(:access_token => access_token)
    end
  end

  namespace :athlete do
    get do
      client.retrieve_current_athlete
    end


    get ':key' do
      client.retrieve_current_athlete.fetch(params[:key], {})
    end
  end
end
