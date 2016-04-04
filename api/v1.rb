require "v1/athlete"
require "v1/activities"

module StravaTFL
  class V1 < Grape::API
    version 'v1', using: :path, vendor: 'StravaTFL'
    content_type :json, 'application/json'
    prefix :api
    format :json

    mount Athlete
    mount Activities

    route :any, '*path' do
      raise Strava::Api::V3::ClientError.new(404, '{"message":"Not Found"}')
    end
  end
end
