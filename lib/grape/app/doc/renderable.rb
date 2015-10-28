module Grape::App::Doc::Renderable

  def render(name, namespace)
    template = File.read File.expand_path("../templates/#{name}.md.erb", __FILE__)
    ERB.new(template, nil, '-').result(namespace.instance_eval { binding })
  end

end
