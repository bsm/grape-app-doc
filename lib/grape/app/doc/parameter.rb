class Grape::App::Doc::Parameter
  include Grape::App::Doc::Renderable

  attr_reader :param, :type, :desc

  def initialize(param, opts = {})
    @param = param
    @type  = norm_type(opts[:type])
    @desc  = opts[:desc]
    @required = opts[:required]
  end

  def required?
    !!@required
  end

  private

    def norm_type(type)
      type.sub "BigDecimal", "Decimal"
    end

end
