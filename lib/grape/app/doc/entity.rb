class Grape::App::Doc::Entity
  attr_reader :name, :desc, :uid, :attributes

  def initialize(klass, registry)
    @name = (klass.meta[:type] if klass.respond_to?(:meta)) || klass.name.gsub('::Entity', '')
    @desc = (klass.meta[:desc] || klass.meta[:description] if klass.respond_to?(:meta)) || ""
    @uid  = [name.parameterize, Grape::App::Doc.next_increment!].join('-')

    exposures = klass.root_exposures
    exposures = exposures.map do |key, opts|
      LegacyExposure.new(key, opts[:using], opts[:documentation])
    end if klass.root_exposures.is_a?(Hash)

    @attributes = exposures.map do |exp|
      doc = exp.documentation.try(:dup)
      unless doc.is_a?(Hash)
        Grape::App::Doc.doc_error("#{klass}: #{name} exposure does not have documentation")
        next
      end
      unless doc.key?(:type)
        Grape::App::Doc.doc_error("#{klass}: #{name} exposure does not have :type documentation")
        next
      end
      if exp.respond_to?(:using_class) && exp.using_class
        registry.register(exp.using_class)
      end
      Grape::App::Doc::Attribute.new(exp.key, doc)
    end.compact
  end

  def example
    @example ||= attributes.inject({}) do |acc, attr|
      acc[attr.key] = attr.type
      acc
    end
  end

  class Registry < Hash
    def register(klass)
      self[klass] ||= Grape::App::Doc::Entity.new(klass, self) if klass
    end
  end
  LegacyExposure = Struct.new(:key, :using_class, :documentation)

end
