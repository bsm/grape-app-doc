require 'grape-app'
require 'grape-entity'
require 'active_support/core_ext/module/attribute_accessors'
require 'rack/utils'

module Grape::App::Doc
  extend self

  def config
    Grape::App::Doc::Config
  end

  def configure(&block)
    config = Grape::App::Doc::Config
    block.call(config) if block
    config
  end

  def create(api = Grape::App)
    Grape::App::Doc::Document.new(api)
  end

  def next_increment!
    @increment ||= 0
    @increment += 1
  end

  def doc_error(message)
    method = config.fail_on_errors ? :abort : :warn
    Kernel.send method, " ! #{message}"
  end

end

%w|
config
endpoint
document
header
parameter
attribute
entity
|.each do |name|
  require "grape/app/doc/#{name}"
end
