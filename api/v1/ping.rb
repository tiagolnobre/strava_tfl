  class Ping < Grape::API
    format :json

    get '/ping' do
      { ping: StravaTFL::CONFIG_FILE }
    end
  end
