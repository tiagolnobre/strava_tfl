require "erb"
class ApiErrorHandler < Grape::Middleware::Error
  def call!(env)
    @env = env
    begin
      @app.call(@env)
    rescue Exception => e
      # binding.remote_pry
      case e.http_status
      when 401, 404, 500
        @error = JSON.parse(e.response_body) || e.message
        raw = File.read(File.expand_path('../../../app/layouts/error.html.erb', __FILE__))

        [e.http_status, { 'Content-Type' => "text/html" }, [ERB.new(raw).result(binding)]]
      else
        [e]
      end
    end
  end
end
