module StravaTFL
  class Healthcheck < Grape::API
    content_type :json, 'application/json'
    format :json

    namespace "healthcheck" do
      get do
        { status: "ok" }
      end
    end
  end
end
