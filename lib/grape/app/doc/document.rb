class Grape::App::Doc::Document

  attr_reader :entities, :endpoints

  def initialize(api = Grape::App)
    registry   = Grape::App::Doc::Entity::Registry.new
    @endpoints = api.routes.map do |route|
      Grape::App::Doc::Endpoint.new(route, registry)
    end
    @entities  = registry.values
  end

  # @param [String|Symbol] template path
  # @return [String] output formatted as template
  def output(template)
    template = File.expand_path("../templates/#{template}.erb") unless File.exist?(template)
    ERB.new(File.read(template), nil, '-').result(binding)
  end

end
