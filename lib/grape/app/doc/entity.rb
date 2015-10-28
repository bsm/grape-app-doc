class Grape::App::Doc::Entity
  include Grape::App::Doc::Renderable

  @@next_id = 0

  def self.next_id
    @@next_id += 1
  end

  def initialize(entity)
    @entity = entity
  end

  def description
    @entity.meta[:description]
  end

  def type
    @type ||= @entity.meta[:type] || @entity.to_s.gsub("::Entity", "")
  end

  def uid
    @uid ||= [type.parameterize, self.class.next_id].join("-")
  end

  def example
    @example ||= attributes.inject({}) do |acc, attr|
      acc[attr.key] = attr.type
      acc
    end
  end

  def attributes
    @attributes ||= @entity.root_exposures.map do |exp|
      opts = exp.documentation.try(:dup) || {}
      opts[:type] = exp.using_class if exp.respond_to?(:using_class)
      Grape::App::Doc::Attribute.new(exp.key, opts)
    end
  end

end
