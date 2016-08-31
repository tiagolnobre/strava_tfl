require 'date'

class Activities < Grape::API
  content_type :html, 'text/html'
  content_type :json, 'application/json'

  default_format :json

  helpers SharedHelpers

  helpers do
    def query_to_hash
      Rack::Utils.parse_nested_query(request.query_string)
    end
  end

  before do
    access_token!
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
      i = 1
      activities = []
      while activities_page = client.list_athlete_activities(query_to_hash.merge("page" => i))
        break if activities_page.count == 0
        i += 1
        activities << activities_page
      end
      activities.flatten!

      number_activities = activities.count do |activity|
        if params[:weekends]
          activity
        else
          date = Date.parse(activity['start_date'])
          !(date.saturday? || date.sunday?)
        end
      end

      @result = { activities: number_activities,
        weekends: params[:weekends],
        price: params[:price],
        total: number_activities * params[:price] }


      if env['api.format'] == :json
        @result
      else
        raw = File.read(File.expand_path('../../../app/layouts/result.html.erb', __FILE__))
        ERB.new(raw).result(binding)
      end

    end
  end
end
