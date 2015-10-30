class Grape::App::Doc::Attribute
  attr_reader :key, :type, :desc, :values, :default

  def initialize(key, opts = {})
    @key     = key
    @type    = opts[:type]
    @desc    = opts[:desc] || opts[:description] || ""
    @values  = opts[:values] || []
    @default = opts[:default]
  end
end
