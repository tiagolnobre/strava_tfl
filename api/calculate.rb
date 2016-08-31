module StravaTFL
  class Calculate < Grape::API
    content_type :html, 'text/html'

    namespace "calculate" do
      get do
        # change to be erb :index
        raw = File.read(File.expand_path('../../app/layouts/calculate.html.erb', __FILE__))
        ERB.new(raw).result(binding)
      end

      post do
        initial_date = Time.strptime(params[:initial_date], "%m/%d/%Y").to_i
        final_date = Time.strptime(params[:final_date], "%m/%d/%Y").to_i

        redirect "/api/v1/activities/count?before=#{final_date}&after=#{initial_date}&price=#{params[:price]}&format=html"
      end
    end
  end
end
