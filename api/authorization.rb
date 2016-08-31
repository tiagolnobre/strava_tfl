module StravaTFL
  class Authorization < Grape::API
    format :json
    helpers SharedHelpers

    helpers do
      def get_access_token
        @get_access_token ||= JSON.parse(request_token.body)["access_token"]
      end

      def request_token
        error!( { error_message: "Set STRAVA_API_SECRET environment variable" } ,401) unless CONFIG_FILE["authentication"]["client_secret"]

        uri = URI.parse("#{CONFIG_FILE["endpoint"]["strava_api"]}#{CONFIG_FILE["endpoint"]["token_exchange"]}")
        @request_token ||= Net::HTTP.post_form(uri, { "client_id" => CONFIG_FILE["authentication"]["client_id"],
                                                      "client_secret" => CONFIG_FILE["authentication"]["client_secret"],
                                                      "code" => request.env["rack.request.query_hash"]["code"]})
      end
    end

    namespace :auth do
      get "callback" do
        env['rack.session'][:access_token] = get_access_token

        redirect "/calculate"
      end

      get "token" do
        access_token!
        { :access_token => env['rack.session'][:access_token] }
      end
    end
  end
end
