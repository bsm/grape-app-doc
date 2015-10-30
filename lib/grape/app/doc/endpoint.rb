class Grape::App::Doc::Endpoint
  Status = Struct.new(:code, :desc, :entity)

  attr_reader :headers, :failure, :success, :version, :params, :method,
              :namespace, :description, :details, :name, :raw_path

  def initialize(route, registry)
    @version     = route.route_version || ''
    @method      = route.route_method || 'GET'
    @namespace   = route.route_namespace || ''
    @description = route.route_description || ''
    @details     = route.route_details || ''
    @name        = route.route_named
    @raw_path    = route.route_path

    @success  = parse_status(route, :success, registry, route.route_success || route.route_entity || [200, "OK"])
    @failure  = (route.route_failure || route.route_http_codes || []).map do |item|
      parse_status(route, :failure, registry, item)
    end.compact
    @headers  = (route.route_headers || {}).map do |name, opts|
      Grape::App::Doc::Header.new(name, opts)
    end
    @params   = (route.route_params || {}).map do |name, opts|
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

    def parse_status(route, kind, registry, item)
      status = if entity_class?(item)
        Status.new(200, "OK", registry.register(item))
      elsif item.is_a?(Array) && !item.empty?
        code = case item[0] when Integer then item[0] when Symbol then Rack::Utils::SYMBOL_TO_STATUS_CODE[item[0]] end
        if code
          desc  = item[1] if item[1].is_a?(String)
          klass = item[2] if entity_class?(item[2])
          Status.new(code, desc, registry.register(klass))
        end
      end

      unless status
        Grape::App::Doc.doc_error("route #{route} contains an invalid #{kind} definition #{item.inspect}")
      end
      status
    end

    def entity_class?(item)
      item.is_a?(Class) && item <= Grape::Entity
    end

end
