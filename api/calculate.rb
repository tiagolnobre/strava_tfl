module StravaTFL
  class Calculate < Grape::API
    content_type :html, 'text/html'

    namespace "calculate" do
      get do
        # change to be erb :index
        raw = File.read(File.expand_path('../../app/layouts/calculate.html.erb', __FILE__))
        ERB.new(raw).result(binding)
      end
    end
  end
end
