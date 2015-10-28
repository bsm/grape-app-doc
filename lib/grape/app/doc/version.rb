class Grape::App::Doc::Version
  include Grape::App::Doc::Renderable

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
    entity = store_entity(raw.route_entity)
    @endpoints.push Grape::App::Doc::Endpoint.new(@host, raw, entity)
  end

  private

  def store_entity(klass)
    return @entities[klass.name] if @entities.key?(klass.name)

    unless klass <= Grape::Entity
      warn "[WARNING] unable to document entity #{version} #{klass} #{version} - not a Grape::Entity"
      return
    end

    # Store entity
    @entities[klass.name] = Grape::App::Doc::Entity.new(klass)

    # Search for sub-entities
    klass.root_exposures.each do |exposure|
      store_entity(exposure.using_class) if exposure.respond_to?(:using_class)
    end
    @entities[klass.name]
  end

end
