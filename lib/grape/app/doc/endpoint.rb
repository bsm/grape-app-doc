class Grape::App::Doc::Endpoint < SimpleDelegator
  include Grape::App::Doc::Renderable

  delegate :route_namespace,
           :route_path,
           :route_method,
           :route_description,
           :route_detail,
           :route_entity,
           :route_failure,
           :route_named,
           :route_headers,
           :route_version,
           :route_params,
           :to_s,
           to: '__getobj__'

  attr_reader :status, :entity, :host

  def initialize(host, obj, status, entity)
    @host, @status, @entity = host, status, entity
    super(obj)
  end

  def named
    @named ||= route_named || [scope, route_description.downcase.gsub(/\W+/, '.')].join(".")
  end

  def scope
    route_namespace.split('/').last ||
      route_path.split("/:version").last.match('\/(\w*?)[\.\/\(]').captures.first
  end

  def headers
    @headers ||= (route_headers || []).map do |name, opts|
      Grape::App::Doc::Header.new(name, opts) if opts.is_a?(Hash)
    end.compact
  end

  def params
    @params ||= (route_params || []).map do |name, opts|
      Grape::App::Doc::Parameter.new(name, opts) if opts.is_a?(Hash)
    end.compact
  end

  def url
    [host, path].join
  end

  def example_url
    num = 0
    url.gsub(/\/\:\w+/) {|m| "/#{num+=1}" }
  end

  def path
    route_path.sub(":version", route_version.to_s).sub("(.json)", "").sub("(.:format)", "")
  end

end
