require 'date'

class Activities < Grape::API
  format :json

  helpers do
    def access_token
      env['rack.session'][:access_token]
    end

    def client
      @client ||= Strava::Api::V3::Client.new(access_token: access_token)
    end

    def query_to_hash
      Rack::Utils.parse_nested_query(request.query_string)
    end
  end

  namespace :activities do
    desc 'This endpoint returns a list of activities'

    desc 'Return activities', {:params => {
    "id" => { :description => "Thing id.", :required => true }
  }}
    params do
      optional :before, type: String, desc: 'seconds since UNIX epoch, result will start with activities whose start_date is before this value'
      optional :after, type: String, desc: 'seconds since UNIX epoch, result will start with activities whose start_date is after this value, sorted oldest first'
    end
    get do
      client.list_athlete_activities(query_to_hash)
    end

    desc 'Return cost of group activities'
    params do
      requires :before, type: String, desc: 'seconds since UNIX epoch, result will start with activities whose start_date is before this value'
      optional :after, type: String, desc: 'seconds since UNIX epoch, result will start with activities whose start_date is after this value, sorted oldest first'
      optional :weekends, type: Boolean, desc: 'with or without weekends', default: false
      requires :price, type: Float, desc: 'Price of the day journey'
    end
    get 'count' do
      activities = client.list_athlete_activities(query_to_hash)

      number_activities = activities.count do |activity|
        if params[:weekends]
          activity
        else
          date = Date.parse(activity['start_date'])
          !(date.saturday? || date.sunday?)
        end
      end

      { activities: number_activities,
        price: params[:price],
        total: number_activities * params[:price] }
    end
  end
end
