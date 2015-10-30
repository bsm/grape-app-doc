class Grape::App::Doc::Header
  attr_reader :name, :opts, :desc

  def initialize(name, opts = {})
    @name = name.to_s
    @opts = opts.dup
    @desc = opts[:desc] || opts[:description] || ""
  end
end
