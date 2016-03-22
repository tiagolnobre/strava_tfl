module StravaTFL
  class Index < Grape::API
    content_type :html, 'text/html'

    get do
      # change to be erb :index
      raw = File.read(File.expand_path('../../app/layouts/index.html.erb', __FILE__))
      ERB.new(raw).result(binding)
    end

    namespace :api do
      get '' do
        redirect "docs/v1.json"
      end

      #fix redirect
      get 'v1' do
        redirect "../docs/v1.json"
      end
    end
  end
end
