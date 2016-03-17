module StravaTFL
  CONFIG_FILE = YAML.load(File.read("#{File.join(File.dirname(__FILE__), '..', 'config')}/conf.yml"))

  class API < Grape::API
    use Rack::Session::Cookie

    use ApiErrorHandler

    mount StravaTFL::Index
    mount StravaTFL::Authorization
    mount StravaTFL::V1

    add_swagger_documentation(
      api_version: 'v1',
      mount_path: "/docs/v1",
      hide_documentation_path: true
    )
  end
end
