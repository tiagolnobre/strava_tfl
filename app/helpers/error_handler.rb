class ApiErrorHandler < Grape::Middleware::Error
  def call!(env)
    @env = env
    begin
      @app.call(@env)
    rescue Exception => e
      raw = File.read(File.expand_path('../../../app/layouts/error.html.erb', __FILE__))

      status = if defined?(e.http_status)
         e.http_status
       elsif defined?(e.status)
         e.status
       else
         500
       end

      case status
      when 400, 401, 404
        @error = {"message" => e.message}
      else
        @error = {"message" => "Undefined error", "errors" => "Internal Server Error"}
      end
      [status, { 'Content-Type' => "text/html" }, [ERB.new(raw).result(binding)]]
    end
  end
end
