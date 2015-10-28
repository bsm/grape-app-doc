class Grape::App::Doc::Document
  include Grape::App::Doc::Renderable

  def initialize(host, api)
    @host     = host
    @versions = {}

    api.routes.each do |raw|
      unless raw.route_entity
        warn "[WARNING] unable to document route #{raw} - no `success` in route description"
        next
      end

      version = get_version(raw.route_version)
      version.store(raw)
    end
  end

  def versions
    @versions.values.sort_by {|v| v.version.to_s }
  end

  def output
    render :document, self
  end

  private

    def get_version(name)
      @versions[name] ||= Grape::App::Doc::Version.new(@host, name)
    end

end
