class Grape::App::Doc::Parameter
  attr_reader :name, :doc, :values, :default, :type, :desc

  def initialize(name, opts = {})
    @name     = name.to_s
    @doc      = opts[:documentation] || {}
    @desc     = doc[:desc] || doc[:description] || ''
    @values   = opts[:values] || []
    @default  = opts[:default]
    @type     = normalize_type(doc[:type] || opts[:type])
    @required = opts[:required]
  end

  def required?
    @required
  end

  private

    def normalize_type(str)
      return 'String' unless str.is_a?(String)

      str = str.dup
      str.sub! 'Virtus::Attribute::', ''
      str.sub! 'Axiom::Types::', ''
      str.sub! 'BigDecimal', 'Decimal'
      str
    end

end
