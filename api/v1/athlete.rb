class Athlete < Grape::API
  format :json

  helpers SharedHelpers

  before do
    access_token!
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
