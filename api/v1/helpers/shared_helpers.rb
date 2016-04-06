module SharedHelpers

  def session
    env['rack.session']
  end

  def access_token
    env['rack.session'][:access_token]
  end

  def access_token?
    !!access_token
  end

  def access_token!
    error!( { error_message: "Invalid access token." } ,401) unless access_token?
  end

  def client
    @client ||= Strava::Api::V3::Client.new(:access_token => access_token)
  end
end
