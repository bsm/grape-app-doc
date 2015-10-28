class Grape::App::Doc::Header
  include Grape::App::Doc::Renderable

  attr_reader :header, :desc

  def initialize(header, opts = {})
    @header = header
    @desc   = opts[:description] || opts[:desc]
    @required = opts[:required]
  end

  def required?
    !!@required
  end

end
