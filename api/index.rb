module StravaTFL
  class Index < Grape::API
    content_type :html, 'text/html'

    get do
      File.read(File.join('public', 'index.html'))
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
