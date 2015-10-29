class Grape::App::Doc::Parameter
  include Grape::App::Doc::Renderable

  attr_reader :param, :type, :desc

  def initialize(param, opts = {})
    doc = opts[:documentation] || {}
    @param = param
    @type  = norm_type(doc[:type] || opts[:type], doc[:is_array])
    @desc  = opts[:desc]
    @required = opts[:required]
  end

  def required?
    !!@required
  end

  private

    def norm_type(type, is_array)
      kind = type.to_s.dup
      kind.sub!("Virtus::Attribute::Boolean", "Boolean")
      kind.sub!("BigDecimal", "Decimal")
      kind.sub!(/^\[([^\]]*)\]$/, '\1[]')
      kind = "#{kind}[]" if is_array
      kind
    end

end
