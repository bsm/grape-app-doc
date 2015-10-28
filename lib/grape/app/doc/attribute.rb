class Grape::App::Doc::Attribute
  include Grape::App::Doc::Renderable

  attr_reader :key, :type, :desc, :values, :default

  def initialize(key, opts = {})
    @key  = key
    @type = norm_type(opts[:type], opts[:is_array])
    @desc = opts[:desc]
    @values  = opts[:values] || []
    @default = opts[:default]
  end

  private

    def norm_type(type, is_array)
      kind = if type == BigDecimal
       "Decimal"
      elsif type <= Grape::Entity
        type.meta[:type] || type.name.sub('::Entity', '')
      else
        type.to_s
      end
      [kind, (is_array ? "[]" : nil)].join
    end

end
