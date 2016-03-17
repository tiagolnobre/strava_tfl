class Activities < Grape::API
  format :json

  helpers do
    def access_token
      env['rack.session'][:access_token]
    end

    def client
      @client ||= Strava::Api::V3::Client.new(:access_token => access_token)
    end
  end

  namespace :activities do
    get do
      client.list_athlete_activities
    end

  end
end
