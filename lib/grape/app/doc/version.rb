class Grape::App::Doc::Version
  include Grape::App::Doc::Renderable

  STATUSES = {
    ok: 200,
    created: 201,
    no_content: 204,
    not_modified: 304,
    unauthorized: 401,
    forbidden: 403,
    not_found: 404,
    conflict: 409,
    unprocessable_entity: 422,
  }

  attr_reader :version, :endpoints

  def initialize(host, version)
    @host      = host
    @version   = version
    @entities  = {}
    @endpoints = []
  end

  def entities
    @entities.values.sort_by {|e| e.type.to_s }
  end

  def store(raw)
    success = Array(raw.route_entity)
    status  = detect_status(success) || 200
    entity  = detect_entity(success)
    @endpoints.push Grape::App::Doc::Endpoint.new(@host, raw, status, entity)
  end

  private

  def detect_entity(list)
    list.each do |item|
      return store_entity(item) if item.is_a?(Class) && item <= Grape::Entity
    end
    nil
  end

  def detect_status(list)
    list.each do |item|
      case item
      when Numeric
        return item
      when Symbol
        return STATUSES[item]
      end
    end
    nil
  end

  def store_entity(klass)
    return @entities[klass.name] if @entities.key?(klass.name)

    # Store entity
    @entities[klass.name] = Grape::App::Doc::Entity.new(klass)

    # Search for sub-entities
    klass.root_exposures.each do |exposure|
      store_entity(exposure.using_class) if exposure.respond_to?(:using_class)
    end
    @entities[klass.name]
  end

end
