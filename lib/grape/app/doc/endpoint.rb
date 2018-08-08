class Grape::App::Doc::Endpoint
  Status = Struct.new(:code, :desc, :entity)

  attr_reader :headers, :failure, :success, :version, :params, :request_method,
              :namespace, :description, :details, :raw_path

  def initialize(route, registry)
    @request_method = route.request_method || 'GET'

    @version     = route.version || ''
    @namespace   = route.namespace || ''
    @description = route.description || ''
    @details     = route.details || ''
    @raw_path    = route.path

    @success  = parse_status(route, registry, route.entity || [200, "OK"])
    @failure  = Array(route.http_codes).map do |item|
      parse_status(route, registry, item)
    end.compact
    @headers  = (route.headers || {}).map do |name, opts|
      Grape::App::Doc::Header.new(name, opts)
    end
    @params   = (route.params || {}).map do |name, opts|
      Grape::App::Doc::Parameter.new(name, opts) if opts.is_a?(Hash)
    end.compact
  end

  # @return [String] friendly path string
  def path
    @path ||= raw_path.sub(':version', version).sub(/\(\.[^\)]+$/, '')
  end

  # @return [String] extracted the resource name
  def resource
    namespace.split('/').last ||
      raw_path.split('/:version').last.match('\/(\w*?)[\.\/\(]').captures.first
  end

  private

  def parse_status(route, registry, item)
    if item.is_a?(Array) && item.size > 1
      code, desc, entity = item
      code = Rack::Utils::SYMBOL_TO_STATUS_CODE[code] if code.is_a?(Symbol)
      Status.new(code, desc, registry.register(entity))
    elsif item.is_a?(Class) && item <= Grape::Entity
      Status.new(200, "OK", registry.register(item))
    else
      Grape::App::Doc.doc_error("route #{route} contains an invalid definition #{item.inspect}")
      nil
    end
  end

end
