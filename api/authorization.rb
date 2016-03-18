module StravaTFL
  class Authorization < Grape::API
    format :json

    helpers do
      def session
        env['rack.session']
      end
    end

    helpers do
      def access_token
        @access_token ||= JSON.parse(request_token.body)["access_token"]
      end

      def request_token
        uri = URI.parse("#{CONFIG_FILE["endpoint"]["strava_api"]}#{CONFIG_FILE["endpoint"]["token_exchange"]}")
        @request_token ||= Net::HTTP.post_form(uri, { "client_id" => CONFIG_FILE["authentication"]["client_id"],
                                                      "client_secret" => CONFIG_FILE["authentication"]["client_secret"],
                                                      "code" => request.env["rack.request.query_hash"]["code"]})
      end
    end

    namespace :auth do
      get "callback" do
        env['rack.session'][:access_token] = access_token

        redirect "token"
      end

      get "token" do
        error!( { error_message: "Invalid access token." } ,401) unless env['rack.session'][:access_token]
        { :access_token => env['rack.session'][:access_token] }
      end
    end
  end
end
